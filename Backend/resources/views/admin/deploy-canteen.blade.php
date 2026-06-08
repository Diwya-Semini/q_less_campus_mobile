@extends('layouts.admin')

@section('content')
<div class="p-6 max-w-7xl mx-auto space-y-8">
    
    <div>
        <h1 class="text-3xl font-black text-white tracking-tight">Deploy & Manage Canteens</h1>
        <p class="text-gray-400 mt-1">Initialize new campus operational tenant hubs or manage active facility subscriptions.</p>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
        
        <div class="lg:col-span-5 bg-white/[0.02] border border-white/5 rounded-3xl p-6 backdrop-blur-2xl shadow-2xl">
            <h3 class="text-lg font-bold text-white mb-4 tracking-tight">Deploy New Station</h3>
            
            <form action="{{ route('admin.canteens.store') }}" method="POST" class="space-y-5">
                @csrf

                <div>
                    <label class="block text-[11px] font-bold uppercase tracking-wider text-gray-400 mb-2">Canteen Outlet Name</label>
                    <input type="text" name="name" placeholder="e.g., SLIIT - Main Food Court" required
                           class="w-full bg-white/[0.03] border border-white/10 rounded-xl px-4 py-3 text-white placeholder-gray-500 focus:outline-none focus:border-orange-500 transition text-sm">
                </div>

                <div>
                    <label class="block text-[11px] font-bold uppercase tracking-wider text-gray-400 mb-2">Campus Location Region</label>
                    <input type="text" name="location" placeholder="e.g., Malabe" required
                           class="w-full bg-white/[0.03] border border-white/10 rounded-xl px-4 py-3 text-white placeholder-gray-500 focus:outline-none focus:border-orange-500 transition text-sm">
                </div>

                <div>
                    <label class="block text-[11px] font-bold uppercase tracking-wider text-gray-400 mb-2">Operating Hours Summary</label>
                    <input type="text" name="operating_hours" placeholder="e.g., 7:30 AM - 8:00 PM" required
                           class="w-full bg-white/[0.03] border border-white/10 rounded-xl px-4 py-3 text-white placeholder-gray-500 focus:outline-none focus:border-orange-500 transition text-sm">
                </div>

                <div>
                    <label class="block text-[11px] font-bold uppercase tracking-wider text-gray-400 mb-2">Initial Status</label>
                    <select name="is_open" class="w-full bg-white/[0.03] border border-white/10 rounded-xl px-4 py-3 text-white focus:outline-none focus:border-orange-500 transition text-sm">
                        <option value="1" class="bg-[#0f0f13]">Open / Active</option>
                        <option value="0" class="bg-[#0f0f13]">Closed / Suspended</option>
                    </select>
                </div>

                <button type="submit" class="w-full bg-orange-500 hover:bg-orange-600 text-white py-3.5 rounded-xl text-sm font-bold shadow-lg shadow-orange-500/10 transition mt-2">
                    Deploy Infrastructure
                </button>
            </form>
        </div>

        <div class="lg:col-span-7 space-y-4">
            <h3 class="text-lg font-bold text-gray-300 tracking-tight">Active Tenant Registry</h3>
            
            <div class="bg-white/[0.01] border border-white/5 rounded-2xl overflow-hidden shadow-xl">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="border-b border-white/5 bg-white/[0.01] text-[11px] font-bold uppercase tracking-wider text-gray-400">
                            <th class="p-4">Canteen Hub Description</th>
                            <th class="p-4">Operational Hours</th>
                            <th class="p-4 text-center">Action Panel</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-white/5 text-sm text-gray-300">
                        @forelse($canteens as $canteen)
                            <tr class="hover:bg-white/[0.01] transition-colors">
                                <td class="p-4">
                                    <span class="font-bold text-white block text-base">{{ $canteen->name }}</span>
                                    <span class="text-xs text-orange-500/70 font-semibold">{{ $canteen->location }}</span>
                                </td>
                                <td class="p-4 text-xs text-gray-400 font-medium">
                                    {{ $canteen->operating_hours }}
                                </td>
                                <td class="p-4 text-center">
                                    <form action="{{ route('admin.canteens.cancel', $canteen->id) }}" method="POST" 
                                          onsubmit="return confirm('Are you absolutely sure you want to cancel the subscription for {{ $canteen->name }}? This will clear all linked menu structures.');">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="border border-red-500/20 hover:border-red-500 bg-red-500/5 hover:bg-red-500/10 text-red-400 px-3.5 py-2 rounded-xl text-xs font-bold transition">
                                            Cancel Subscription
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="3" class="p-8 text-center text-gray-500 text-xs">No registered canteens are deployed onto the platform index yet.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>
@endsection