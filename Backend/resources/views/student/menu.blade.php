@extends('layouts.student')

@section('content')
<div class="max-w-6xl mx-auto pb-24 relative"> 
    
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-10 mt-2 gap-4">
        <div class="flex items-center gap-3">
            <div class="w-10 h-10 rounded-full bg-white/5 border border-white/10 flex items-center justify-center">
                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path></svg>
            </div>
            <h2 class="text-xl font-bold text-white tracking-wide">Main Canteen</h2>
        </div>

        <form action="{{ route('student.menu') }}" method="GET" class="w-full md:w-72">
            @if(request('category'))
                <input type="hidden" name="category" value="{{ request('category') }}">
            @endif
            <div class="relative">
                <input type="text" name="search" value="{{ $currentSearch }}" placeholder="Search in site..." 
                       class="w-full pl-4 pr-10 py-2 bg-[#1a1a21] border border-white/5 rounded-xl text-sm text-white placeholder-gray-500 focus:outline-none focus:border-orange-500 focus:ring-1 focus:ring-orange-500 transition-all shadow-inner">
                <button type="submit" class="absolute inset-y-0 right-0 pr-3 flex items-center">
                    <svg class="w-4 h-4 text-gray-400 hover:text-orange-500 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                </button>
            </div>
        </form>
    </div>

    <div class="mb-8">
        <h1 class="text-4xl font-black text-white tracking-tight">Campus Menu</h1>
        <p class="text-gray-400 mt-2 text-lg">Order ahead and skip the line.</p>
    </div>

    <div class="flex flex-wrap gap-3 mb-8">
        @php
            $categories = ['All', 'Mains', 'Snacks', 'Drinks', 'Pastry'];
        @endphp

        @foreach($categories as $category)
            <a href="{{ route('student.menu', ['category' => $category, 'search' => $currentSearch]) }}" 
               class="px-5 py-2 rounded-full font-bold text-sm transition-all duration-200 border 
               {{ $currentCategory === $category 
                    ? 'bg-orange-600 text-white border-orange-500 shadow-[0_0_15px_rgba(234,88,12,0.4)]' 
                    : 'bg-white/[0.03] text-gray-400 border-white/5 hover:bg-white/10 hover:text-white' }}">
                {{ $category }}
            </a>
        @endforeach
    </div>

    @if($products->isEmpty())
        <div class="text-center py-20 bg-white/[0.02] border border-white/5 rounded-2xl mb-8 shadow-inner">
            <svg class="w-16 h-16 text-gray-600 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
            <p class="text-gray-400 text-lg font-medium">No food found matching your search.</p>
            <a href="{{ route('student.menu') }}" class="text-orange-400 hover:text-orange-300 text-sm font-bold mt-3 inline-block transition-colors">Clear all filters</a>
        </div>
    @else
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            @foreach($products as $product)
                <x-food-card :product="$product" />
            @endforeach
        </div>
    @endif

</div>

@if($itemCount > 0)
    <div class="fixed bottom-0 left-0 md:left-72 right-0 bg-orange-600 hover:bg-orange-500 text-white font-bold shadow-[0_-8px_24px_rgba(0,0,0,0.5)] transition duration-300 z-50">
        <a href="{{ route('student.cart.view') }}" class="max-w-6xl mx-auto px-6 py-2.5 flex justify-between items-center text-sm md:text-base tracking-wide">            <div class="flex items-center gap-3">
                <div class="bg-white/20 p-1.5 rounded-lg">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path></svg>
                </div>
                <span>View Cart ({{ $itemCount }} {{ $itemCount == 1 ? 'item' : 'items' }})</span>
            </div>
            <div class="flex items-center gap-2 bg-black/20 px-4 py-1.5 rounded-xl border border-white/10 hover:bg-black/30 transition-colors">
                <span>Checkout</span>
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
            </div>
        </a>
    </div>
@endif
@endsection