<div wire:poll.5s class="max-w-7xl mx-auto pb-12 relative">
    
    <div class="flex justify-between items-end mb-8">
        <div>
            <h1 class="text-3xl font-black text-white tracking-tight">Live Order Board</h1>
            <p class="text-gray-400 mt-1">Manage kitchen workflow and secure handovers.</p>
        </div>
        <div class="flex items-center text-sm font-bold text-gray-500 bg-white/5 px-3 py-1.5 rounded-lg border border-white/10">
            <span class="w-2 h-2 rounded-full bg-green-500 mr-2 animate-pulse"></span>
            Auto-syncing
        </div>
    </div>

    @if($orders->isEmpty())
        <div class="text-center py-20 bg-white/[0.02] border border-white/5 rounded-2xl shadow-inner">
            <svg class="w-16 h-16 text-gray-600 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path></svg>
            <p class="text-gray-400 text-lg font-medium">The kitchen is clear. No active orders.</p>
        </div>
    @else
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            @foreach($orders as $order)
                <div class="bg-white/[0.02] border border-white/5 rounded-2xl p-5 backdrop-blur-xl shadow-lg relative flex flex-col h-full">
                    
                    <div class="absolute top-0 left-0 right-0 h-1.5 rounded-t-2xl 
                        {{ $order->status === 'pending' ? 'bg-red-500' : '' }}
                        {{ $order->status === 'preparing' ? 'bg-orange-500' : '' }}
                        {{ $order->status === 'packing' ? 'bg-yellow-500' : '' }}
                        {{ $order->status === 'ready' ? 'bg-green-500' : '' }}
                    "></div>

                    <div class="flex justify-between items-start mb-4 mt-2">
                        <div>
                            <h3 class="text-white font-black text-lg">Order #{{ $order->id }}</h3>
                            <p class="text-gray-400 text-xs font-medium">{{ $order->user->name ?? 'Student' }}</p>
                        </div>
                        <span class="text-gray-400 text-xs font-bold bg-black/30 border border-white/5 px-2 py-1 rounded-md">
                            {{ $order->created_at->diffForHumans(null, true, true) }}
                        </span>
                    </div>

                    <ul class="flex-1 space-y-3 mb-6 border-t border-white/5 pt-4">
                        @foreach($order->items as $item)
                            <li class="flex items-start text-sm">
                                <span class="font-black text-white bg-white/10 px-2 py-0.5 rounded mr-3 shrink-0">{{ $item->quantity }}x</span>
                                <span class="text-gray-300">{{ $item->product->item_name }}</span>
                            </li>
                        @endforeach
                    </ul>

                    <div class="mt-auto pt-4 border-t border-white/5">
                        
                        @if($order->status === 'pending')
                            <button wire:click="updateOrderStatus({{ $order->id }}, 'preparing')" class="w-full bg-red-500/10 hover:bg-red-500/20 text-red-400 border border-red-500/30 font-bold py-3 px-4 rounded-xl transition duration-200 shadow-inner">
                                Accept & Start Cooking
                            </button>
                        
                        @elseif($order->status === 'preparing')
                            <button wire:click="updateOrderStatus({{ $order->id }}, 'packing')" class="w-full bg-orange-500/10 hover:bg-orange-500/20 text-orange-400 border border-orange-500/30 font-bold py-3 px-4 rounded-xl transition duration-200 shadow-inner">
                                Move to Packing
                            </button>
                            
                        @elseif($order->status === 'packing')
                            <button wire:click="updateOrderStatus({{ $order->id }}, 'ready')" class="w-full bg-yellow-500/10 hover:bg-yellow-500/20 text-yellow-400 border border-yellow-500/30 font-bold py-3 px-4 rounded-xl transition duration-200 shadow-inner">
                                Mark as Ready
                            </button>
                            
                        @elseif($order->status === 'ready')
                            <button wire:click="promptOtp({{ $order->id }})" class="w-full bg-green-600 hover:bg-green-500 text-white font-black py-3 px-4 rounded-xl transition duration-200 shadow-[0_0_15px_rgba(34,197,94,0.3)]">
                                Verify PIN & Handover
                            </button>
                        @endif

                    </div>
                </div>
            @endforeach
        </div>
    @endif

    @if($showOtpModal)
        <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-sm">
            <div class="bg-[#131318] border border-white/10 p-8 rounded-2xl shadow-2xl max-w-sm w-full mx-4 relative overflow-hidden">
                
                <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-orange-500 to-orange-600"></div>

                <div class="text-center mb-6">
                    <div class="w-16 h-16 bg-orange-500/10 rounded-full flex items-center justify-center mx-auto mb-4 border border-orange-500/20">
                        <svg class="w-8 h-8 text-orange-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path></svg>
                    </div>
                    <h2 class="text-2xl font-black text-white mb-1">Verify Handover</h2>
                    <p class="text-gray-400 text-sm">Ask the student for their 4-digit PIN.</p>
                </div>

                @if($otpError)
                    <div class="bg-red-500/10 border border-red-500/20 text-red-400 text-sm font-bold p-3 rounded-lg mb-5 text-center flex items-center justify-center">
                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                        {{ $otpError }}
                    </div>
                @endif

                <input type="text" wire:model="enteredOtp" placeholder="••••" maxlength="4" 
                       class="w-full text-center text-4xl font-black tracking-[0.5em] bg-black/50 border border-white/10 rounded-xl py-4 text-white focus:outline-none focus:border-orange-500 focus:ring-2 focus:ring-orange-500/50 transition-all mb-6 placeholder-gray-700">

                <div class="flex gap-3">
                    <button wire:click="closeOtpModal" class="flex-1 bg-white/5 hover:bg-white/10 border border-white/5 text-white font-bold py-3.5 rounded-xl transition duration-200">
                        Cancel
                    </button>
                    <button wire:click="verifyAndComplete" class="flex-1 bg-orange-600 hover:bg-orange-500 text-white font-black py-3.5 rounded-xl transition duration-200 shadow-[0_0_20px_rgba(234,88,12,0.4)]">
                        Confirm
                    </button>
                </div>
            </div>
        </div>
    @endif

</div>