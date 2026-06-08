<aside class="w-72 h-screen bg-[#131318] border-r border-white/5 flex flex-col shrink-0 hidden md:flex">

    <div class="h-20 flex items-center px-6 border-b border-white/5 shrink-0">
        <div class="w-8 h-8 bg-gradient-to-br from-orange-500 to-orange-600 rounded-lg flex items-center justify-center font-black text-white text-lg shadow-[0_0_15px_rgba(234,88,12,0.4)] mr-3">
            Q
        </div>
        <div>
            <h1 class="text-white font-black text-lg tracking-wide leading-tight">Q-LESS</h1>
            <p class="text-[10px] text-gray-500 font-bold tracking-widest uppercase">Campus Dining</p>
        </div>
    </div>

    <nav class="flex-1 overflow-y-auto py-6 px-4 space-y-1 custom-scrollbar">
        {{ $slot }}
    </nav>

    <div class="p-4 border-t border-white/5 bg-[#131318] shrink-0 mt-auto">
        <div class="flex items-center justify-between">
            <div class="flex items-center overflow-hidden">
                <div class="w-9 h-9 rounded-full bg-orange-500/20 text-orange-500 flex items-center justify-center font-bold text-sm border border-orange-500/30 shrink-0">
                    {{ substr(auth()->user()->name ?? 'U', 0, 1) }}
                </div>
                <div class="ml-3 truncate">
                    <p class="text-sm font-bold text-white truncate">{{ auth()->user()->name ?? 'System User' }}</p>
                    <p class="text-[10px] text-orange-500 font-bold uppercase tracking-wider">
                        {{ auth()->user()->role ?? 'Student' }}
                    </p>
                </div>
            </div>
            
            <form method="POST" action="{{ route('logout') }}" class="shrink-0 ml-2">
                @csrf
                <button type="submit" class="p-2 text-gray-500 hover:text-orange-500 hover:bg-orange-500/10 rounded-lg transition-all duration-200" title="Log Out">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                    </svg>
                </button>
            </form>
        </div>
    </div>
</aside>