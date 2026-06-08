@extends('layouts.student')

@section('content')
<div class="max-w-5xl mx-auto">
    <div class="mb-8">
        <h1 class="text-3xl font-black text-white tracking-tight">Order History</h1>
        <p class="text-gray-400 mt-1">Track your active orders and view past purchases.</p>
    </div>

    @if($orders->count() > 0)
        <div class="space-y-6">
            @foreach($orders as $order)
                <div class="bg-white/[0.02] border border-white/5 rounded-2xl p-6 backdrop-blur-xl shadow-lg relative overflow-hidden">
                    
                    <div class="absolute left-0 top-0 bottom-0 w-1 {{ $order->status === 'pending' ? 'bg-orange-500' : 'bg-green-500' }}"></div>
                    
                    <div class="flex justify-between items-start mb-4">
                        <div>
                            <span class="text-xs font-bold text-gray-500 uppercase tracking-widest">Order #{{ $order->id }}</span>
                            <div class="text-sm text-gray-400 mt-1">{{ $order->created_at->format('d M Y, h:i A') }}</div>
                        </div>
                        
                        <div class="flex items-center gap-3">
                            @if($order->status !== 'completed' && $order->otp)
                                <span class="bg-orange-500 text-white font-mono text-xs font-black px-3 py-1.5 rounded-lg tracking-wider shadow-md">
                                    OTP: {{ $order->otp }}
                                </span>
                            @endif

                            @if($order->status === 'pending')
                                <span class="bg-orange-500/10 text-orange-400 border border-orange-500/20 px-3 py-1 rounded-lg text-sm font-bold flex items-center shadow-inner">
                                    <span class="w-2 h-2 rounded-full bg-orange-500 mr-2 animate-pulse"></span>
                                    In Kitchen
                                </span>
                            @else
                                <span class="bg-green-500/10 text-green-400 border border-green-500/20 px-3 py-1 rounded-lg text-sm font-bold flex items-center shadow-inner">
                                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                    </svg>
                                    Ready / Completed
                                </span>
                            @endif
                        </div>
                    </div>

                    <div class="border-t border-white/5 pt-4 mt-4">
                        <ul class="space-y-3">
                            @foreach($order->items as $item)
                                <li class="flex justify-between text-sm">
                                    <div class="flex items-center text-gray-300">
                                        <span class="font-bold text-white bg-white/10 px-2 py-0.5 rounded-md mr-3">{{ $item->quantity }}x</span>
                                        {{ $item->product->item_name ?? 'Menu Item' }}
                                    </div>
                                    <span class="text-gray-400 font-medium">Rs. {{ number_format($item->price * $item->quantity, 2) }}</span>
                                </li>
                            @endforeach
                        </ul>
                    </div>

                    <div class="border-t border-white/5 pt-4 mt-4 flex justify-between items-center">
                        <span class="text-gray-400 text-sm font-medium">Total Paid</span>
                        <span class="text-xl font-black text-white">Rs. {{ number_format($order->total_amount, 2) }}</span>
                    </div>
                </div>
            @endforeach
        </div>
    @else
        <div class="text-center py-20 bg-white/[0.02] border border-white/5 rounded-2xl">
            <svg class="w-20 h-20 text-gray-600 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 112-2h2a2 2 0 012 2"></path>
            </svg>
            <p class="text-gray-400 text-lg">You haven't placed any orders yet.</p>
            <a href="{{ route('student.menu') }}" class="inline-block mt-4 text-orange-400 hover:text-orange-300 font-bold underline">Explore the menu</a>
        </div>
    @endif
</div>
@endsection