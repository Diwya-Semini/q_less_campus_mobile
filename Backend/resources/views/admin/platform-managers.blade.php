@extends('layouts.admin')

@section('content')
<div class="p-6 max-w-7xl mx-auto space-y-12">
    
    <div>
        <h1 class="text-3xl font-black text-white tracking-tight">Platform Managers</h1>
        <p class="text-gray-400 mt-1">Review independent manager onboarding applications and active vendors.</p>
    </div>

    <div class="space-y-4">
        <h2 class="text-lg font-bold text-orange-400 tracking-tight flex items-center gap-2">
            <span class="w-2 h-2 bg-orange-400 rounded-full animate-pulse"></span>
            Pending Approval Requests ({{ count($pendingManagers) }})
        </h2>

        @if($pendingManagers->isEmpty())
            <div class="bg-white/[0.01] border border-white/5 rounded-2xl p-8 text-center text-gray-500 text-sm">
                No new vendor registration requests are currently pending review.
            </div>
        @else
            <div class="grid grid-cols-1 gap-4">
                @foreach($pendingManagers as $manager)
                    <div class="bg-white/[0.02] border border-white/5 rounded-2xl p-5 flex flex-col md:flex-row justify-between items-start md:items-center gap-4 backdrop-blur-xl">
                        <div>
                            <h4 class="text-base font-bold text-white">{{ $manager->name }}</h4>
                            <p class="text-xs text-gray-400 mt-0.5">{{ $manager->email }}</p>
                            <span class="inline-block bg-orange-500/10 border border-orange-500/20 text-orange-400 text-[10px] uppercase font-black px-2 py-0.5 rounded-md mt-2">
                                Assigned to: {{ $manager->canteen->name ?? 'Unassigned Outlet' }}
                            </span>
                        </div>
                        
                        <div class="flex items-center gap-2 w-full md:w-auto justify-end">
                            <form action="{{ route('admin.managers.reject', $manager->id) }}" method="POST">
                                @csrf
                                <button type="submit" class="border border-red-500/30 hover:border-red-500 bg-red-500/5 hover:bg-red-500/10 text-red-400 px-4 py-2 rounded-xl text-xs font-bold transition">
                                    Decline
                                </button>
                            </form>
                            <form action="{{ route('admin.managers.approve', $manager->id) }}" method="POST">
                                @csrf
                                <button type="submit" class="bg-emerald-500 hover:bg-emerald-600 text-white px-4 py-2 rounded-xl text-xs font-bold shadow-lg shadow-emerald-500/10 transition">
                                    Approve Vendor
                                </button>
                            </form>
                        </div>
                    </div>
                @endforeach
            </div>
        @endif
    </div>

    <div class="space-y-4">
        <h2 class="text-lg font-bold text-gray-300 tracking-tight">Active Platform Vendors</h2>
        
        <div class="bg-white/[0.01] border border-white/5 rounded-2xl overflow-hidden">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="border-b border-white/5 bg-white/[0.01] text-xs font-bold uppercase tracking-wider text-gray-400">
                        <th class="p-4">Manager Details</th>
                        <th class="p-4">Assigned Facility Hub</th>
                        <th class="p-4">Status Flag</th>
                        <th class="p-4">Provisioned Date</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-white/5 text-sm text-gray-300">
                    @forelse($activeManagers as $active)
                        <tr>
                            <td class="p-4">
                                <span class="font-bold text-white block">{{ $active->name }}</span>
                                <span class="text-xs text-gray-500">{{ $active->email }}</span>
                            </td>
                            <td class="p-4 font-medium text-orange-400/80">
                                {{ $active->canteen->name ?? 'Global Platform Scope' }}
                            </td>
                            <td class="p-4">
                                <span class="bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 text-[10px] font-bold px-2 py-0.5 rounded-md uppercase">
                                    Verified Active
                                </span>
                            </td>
                            <td class="p-4 font-mono text-xs text-gray-500">
                                {{ $active->created_at->format('Y-m-d') }}
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="4" class="p-8 text-center text-gray-500 text-xs">No verified platform manager accounts are currently active.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>

</div>
@endsection