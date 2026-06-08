@extends('layouts.student')

@section('content')
<div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
    
    <div class="mb-8 border-b border-white/10 pb-5">
        <h1 class="text-3xl font-black text-white tracking-tight">Select Your Campus</h1>
        <p class="text-gray-400 mt-1">Choose a canteen to view today's menu and place an order.</p>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        @forelse($canteens as $canteen)
            <a href="{{ route('student.menu', $canteen->id) }}" class="block bg-[#16161a] border border-white/5 rounded-2xl p-6 hover:bg-white/5 hover:border-orange-500/50 transition-all duration-300 group cursor-pointer shadow-lg">
                
                <div class="flex justify-between items-start mb-4">
                    <div class="w-10 h-10 rounded-full bg-orange-500/10 flex items-center justify-center text-orange-500 group-hover:bg-orange-500 group-hover:text-white transition-colors">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path></svg>
                    </div>
                    <span class="bg-green-500/10 text-green-400 border border-green-500/20 text-[10px] font-bold px-3 py-1 rounded-full uppercase tracking-widest">Open Now</span>
                </div>

                <h3 class="text-xl font-bold text-white mb-1 group-hover:text-orange-400 transition-colors">{{ $canteen->name }}</h3>
                <p class="text-sm text-gray-400 mb-4">{{ $canteen->location }}</p>

                <div class="pt-4 border-t border-white/5 text-xs text-gray-500 flex justify-between items-center">
                    <span>🕒 {{ $canteen->operating_hours ?? 'Standard Hours' }}</span>
                    <span class="text-orange-500 font-bold group-hover:translate-x-1 transition-transform">View Menu ➔</span>
                </div>
            </a>
        @empty
            <div class="col-span-full p-12 text-center text-gray-500 bg-[#16161a] rounded-2xl border border-white/5">
                No canteens are currently open. Please check back later!
            </div>
        @endforelse
    </div>

</div>
@endsection