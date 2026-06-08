@extends('layouts.admin')

@section('content')
<div class="p-6 max-w-7xl mx-auto">
    
    <div class="flex justify-between items-center mb-8">
        <div>
            <h1 class="text-3xl font-black text-white tracking-tight">Network Canteens</h1>
            <p class="text-gray-400 mt-1">Manage all campus locations across the SaaS platform.</p>
        </div>
        
        <a href="{{ route('admin.canteens.create') }}" class="bg-orange-500 hover:bg-orange-600 text-white px-5 py-2.5 rounded-xl text-sm font-bold transition duration-200 flex items-center gap-2 shadow-lg shadow-orange-500/10">
            <span class="text-base font-normal">+</span> Add New Canteen
        </a>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mt-8">
    @foreach($canteens as $canteen)
        <div class="bg-white/[0.02] border border-white/5 rounded-2xl p-6 backdrop-blur-xl shadow-xl relative overflow-hidden group hover:border-white/10 transition-all duration-300">
            
            <div class="flex justify-between items-start mb-4">
                <span class="px-2.5 py-1 text-xs font-black uppercase tracking-wider rounded-md {{ $canteen->calculated_status === 'OPEN' ? 'bg-green-500/10 text-green-400 border border-green-500/20' : 'bg-red-500/10 text-red-400 border border-red-500/20' }}">
                    {{ $canteen->calculated_status }}
                </span>
            </div>

            <h3 class="text-xl font-black text-white tracking-tight mt-2 group-hover:text-orange-400 transition-colors">
                {{ $canteen->name }}
            </h3>
            <p class="text-orange-500/70 text-sm font-semibold mt-1">
                {{ $canteen->location }}
            </p>

            <div class="border-t border-white/5 pt-4 mt-4 flex justify-between items-center text-xs text-gray-400 font-medium">
                <div class="flex items-center gap-1.5">
                    <svg class="w-4 h-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    {{ $canteen->operating_hours }}
                </div>
                <span class="font-mono text-gray-600">ID: #{{ $canteen->id }}</span>
            </div>
        </div>
    @endforeach
</div>

</div>
@endsection