@props(['product'])

@php
    $isAvailable = (bool)$product->isAvailable;
@endphp

<div class="bg-[#1a1a1a] rounded-2xl border {{ $isAvailable ? 'border-gray-800 hover:border-orange-500/50 hover:shadow-orange-500/10' : 'border-gray-900/80 opacity-70' }} overflow-hidden shadow-lg transition group relative flex flex-col h-full">
    
    @if(!$isAvailable)
        <div class="absolute top-3 right-3 z-20">
            <span class="bg-red-600/90 text-white font-extrabold text-[10px] tracking-widest uppercase px-2.5 py-1 rounded-md shadow-md border border-red-400/40">
                SOLD OUT
            </span>
        </div>
    @endif

    <div class="overflow-hidden relative h-48 bg-[#121215]">
        @if($product->image_url)
            <img src="{{ $product->image_url }}" alt="{{ $product->item_name }}" 
                 class="w-full h-full object-cover transition duration-500 {{ $isAvailable ? 'group-hover:scale-105' : 'brightness-[0.45]' }}">
        @else
            <div class="w-full h-full flex items-center justify-center text-gray-800 font-bold uppercase tracking-widest text-xs">
                No Image
            </div>
        @endif
    </div>

    <div class="p-5 relative z-10 bg-[#1a1a1a] flex flex-col flex-grow justify-between">
        <div>
            <span class="text-xs font-bold {{ $isAvailable ? 'text-orange-500' : 'text-gray-600' }} uppercase tracking-wider">
                {{ $product->category }}
            </span>
            <h3 class="text-lg font-bold {{ $isAvailable ? 'text-white' : 'text-gray-500' }} mt-1 mb-2">
                {{ $product->item_name }}
            </h3>
            <p class="font-semibold {{ $isAvailable ? 'text-gray-300' : 'text-gray-600' }} text-sm">
                Rs. {{ number_format($product->price, 2) }}
            </p>
        </div>
        
        <form action="{{ route('student.cart.add', $product->id) }}" method="POST" class="mt-5">
            @csrf
            @if($isAvailable)
                <button type="submit" class="w-full bg-[#2a2a2a] hover:bg-orange-500 text-white font-bold py-2.5 rounded-xl transition duration-300 text-sm">
                    Add To Cart
                </button>
            @else
                <button type="button" disabled class="w-full bg-[#141417] text-gray-600 font-bold py-2.5 rounded-xl cursor-not-allowed border border-gray-900 text-sm">
                    Unavailable
                </button>
            @endif
        </form>
    </div>
</div>