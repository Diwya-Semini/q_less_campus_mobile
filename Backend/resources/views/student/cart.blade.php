@extends('layouts.student')

@section('content')
<div class="max-w-4xl mx-auto">
    <h1 class="text-3xl font-black text-white tracking-tight mb-8">Your Cart</h1>

    @if(session('error'))
        <div class="mb-6 bg-red-500/10 text-red-400 px-4 py-3 rounded-xl border border-red-500/20">
            {{ session('error') }}
        </div>
    @endif

    @if(count($cart) > 0)
        <div class="bg-white/[0.02] border border-white/5 rounded-2xl p-6 backdrop-blur-xl mb-6 shadow-xl">
            <ul class="divide-y divide-white/5">
                @php $total = 0; @endphp
                @foreach($cart as $id => $details)
                    @php $total += $details['price'] * $details['quantity']; @endphp
                    <li class="py-4 flex items-center justify-between">
                        <div class="flex items-center">
                            <img src="{{ $details['image'] }}" class="w-16 h-16 rounded-xl object-cover border border-white/10 mr-4">
                            <div>
                                <h3 class="text-white font-bold">{{ $details['name'] }}</h3>
                                <p class="text-gray-400 text-sm">Rs. {{ number_format($details['price'], 2) }} each</p>
                            </div>
                        </div>
                        <div class="flex items-center space-x-6">
                            <span class="text-white font-bold px-3 py-1 bg-black/30 rounded-lg border border-white/5">Qty: {{ $details['quantity'] }}</span>
                            <span class="text-orange-400 font-bold w-24 text-right">Rs. {{ number_format($details['price'] * $details['quantity'], 2) }}</span>
                        </div>
                    </li>
                @endforeach
            </ul>
            
            <div class="mt-6 pt-6 border-t border-white/10 flex justify-between items-center">
                <span class="text-xl text-gray-400 font-medium">Total Amount</span>
                <span class="text-3xl font-black text-white">Rs. {{ number_format($total, 2) }}</span>
            </div>
        </div>

        <form action="{{ route('student.checkout') }}" method="POST" class="text-right">
            @csrf
            <button type="submit" class="bg-orange-600 hover:bg-orange-500 text-white font-black text-lg py-4 px-8 rounded-2xl shadow-[0_0_20px_rgba(234,88,12,0.3)] hover:shadow-[0_0_30px_rgba(234,88,12,0.5)] transition duration-300">
                Confirm & Send to Kitchen 🚀
            </button>
        </form>
    @else
        <div class="text-center py-20 bg-white/[0.02] border border-white/5 rounded-2xl">
            <svg class="w-20 h-20 text-gray-600 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path></svg>
            <p class="text-gray-400 text-lg">Your cart is completely empty.</p>
            <a href="{{ route('student.menu') }}" class="inline-block mt-4 text-orange-400 hover:text-orange-300 font-bold underline">Go back to menu</a>
        </div>
    @endif
</div>
@endsection