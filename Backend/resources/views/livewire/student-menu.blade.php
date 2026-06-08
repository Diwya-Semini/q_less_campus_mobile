<div class="max-w-7xl mx-auto py-10 px-4 sm:px-6 lg:px-8 min-h-screen text-white">
    
    @if($generatedOtp)
        <div class="mb-8 bg-green-500/10 border border-green-500/30 p-6 rounded-2xl shadow-lg text-center backdrop-blur-xl">
            <h2 class="text-2xl font-black text-green-400">Order Placed Successfully!</h2>
            <p class="text-gray-400 mt-2">Please present this PIN to the canteen manager to collect your food:</p>
            <div class="inline-block text-5xl font-black text-white tracking-widest mt-4 bg-green-600 px-8 py-3 rounded-xl shadow-[0_0_20px_rgba(22,163,74,0.4)]">
                {{ $generatedOtp }}
            </div>
        </div>
    @endif

    <div class="flex flex-col lg:flex-row gap-8">
        <div class="w-full lg:w-2/3">
            <h2 class="text-2xl font-black tracking-tight mb-6">Today's Menu Selection</h2>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                @foreach($products as $product)
                    <div class="bg-white/[0.02] border border-white/5 rounded-2xl p-5 flex flex-col justify-between hover:border-orange-500/30 transition-all duration-200 hover:bg-white/[0.04]">
                        <div>
                            <div class="flex justify-between items-start gap-4">
                                <h3 class="text-lg font-bold text-white tracking-tight">{{ $product->item_name }}</h3>
                                <span class="text-sm font-black text-orange-400 shrink-0 bg-orange-500/10 px-2.5 py-1 rounded-md">
                                    Rs. {{ number_format($product->price, 2) }}
                                </span>
                            </div>
                            <p class="text-gray-400 text-sm mt-2 line-clamp-2">
                                {{ $product->description ?? 'Freshly prepared campus meal option.' }}
                            </p>
                        </div>
                        
                        <button wire:click="addToCart({{ $product->id }})" class="mt-5 w-full bg-orange-600 hover:bg-orange-500 text-white font-bold py-2.5 rounded-xl transition duration-200 flex justify-center items-center shadow-[0_0_15px_rgba(234,88,12,0.2)]">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                            </svg>
                            Add to Basket
                        </button>
                    </div>
                @endforeach
            </div>
        </div>

        <div class="w-full lg:w-1/3">
            <div class="bg-white/[0.02] border border-white/5 rounded-2xl p-6 backdrop-blur-xl sticky top-6">
                <h2 class="text-xl font-black tracking-tight mb-6 flex items-center border-b border-white/5 pb-4">
                    <svg class="w-5 h-5 mr-2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"></path>
                    </svg>
                    Your Basket Container
                </h2>
                
                @if(count($cart) > 0)
                    <div class="space-y-4 max-h-[300px] overflow-y-auto pr-1">
                        @foreach($cart as $id => $item)
                            <div class="flex justify-between items-center pb-3 border-b border-white/5">
                                <div>
                                    <h4 class="font-bold text-white text-sm">{{ $item['name'] }}</h4>
                                    <div class="text-xs text-gray-400 mt-0.5">
                                        <button wire:click="removeFromCart({{ $id }})" class="text-red-400 font-bold hover:underline mr-1 text-[11px]">Remove</button>
                                        {{ $item['quantity'] }} × Rs. {{ number_format($item['price'], 2) }}
                                    </div>
                                </div>
                                <span class="font-black text-white text-sm">
                                    Rs. {{ number_format($item['price'] * $item['quantity'], 2) }}
                                </span>
                            </div>
                        @endforeach
                    </div>

                    <div class="flex justify-between items-center mt-6 pt-4 border-t border-white/5">
                        <span class="text-gray-400 font-medium">Total Balance</span>
                        <span class="text-2xl font-black text-orange-400">Rs. {{ number_format($this->total, 2) }}</span>
                    </div>

                    <button wire:click="checkout" class="w-full mt-6 bg-orange-600 hover:bg-orange-500 text-white font-black py-3.5 rounded-xl transition duration-200 shadow-[0_0_20px_rgba(234,88,12,0.3)]">
                        Place Order & Generate PIN
                    </button>
                @else
                    <div class="text-center py-12 text-gray-500">
                        <svg class="w-12 h-12 mx-auto text-gray-700 mb-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path>
                        </svg>
                        <p class="text-sm">Your basket is currently empty.</p>
                    </div>
                @endif
            </div>
        </div>
    </div>
</div>