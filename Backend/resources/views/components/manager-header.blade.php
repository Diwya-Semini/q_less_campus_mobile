@props(['title', 'backUrl' => null])

<header class="py-6 px-10 border-b border-gray-800 bg-[#121212] flex items-center justify-between w-full relative z-50">
    
    <div class="flex items-center gap-5">
        @if($backUrl)
            <a href="{{ $backUrl }}" class="w-10 h-10 rounded-full bg-[#1a1a1a] border border-gray-700 flex items-center justify-center text-gray-400 hover:text-white hover:bg-gray-700 hover:border-gray-500 transition shadow-sm">
                <svg class="w-5 h-5 pr-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M15 19l-7-7 7-7"></path></svg>
            </a>
        @endif
        <span class="text-2xl font-bold text-white tracking-wide">{{ $title }}</span>
    </div>

    <div class="relative group cursor-pointer">
        <div class="bg-[#1a1a1a] border border-gray-700 group-hover:bg-gray-700 text-gray-300 group-hover:text-white text-sm font-semibold py-2.5 px-6 rounded-full transition shadow-sm flex items-center gap-2">
            {{ auth()->user()->name ?? 'System Admin' }} 
            <svg class="w-4 h-4 transform group-hover:rotate-180 transition duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
        </div>

        <div class="absolute right-0 mt-2 w-48 bg-[#1a1a1a] rounded-xl shadow-2xl border border-gray-700 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 transform origin-top-right group-hover:translate-y-0 translate-y-2 z-50">
            <div class="p-2 bg-[#1a1a1a] rounded-xl">
                <form method="POST" action="{{ route('logout') }}" class="m-0 p-0">
                    @csrf
                    <button type="submit" class="w-full text-left block px-4 py-2 text-sm text-red-400 hover:bg-red-900/50 hover:text-red-300 rounded-lg transition">
                        Log Out
                    </button>
                </form>
            </div>
        </div>
    </div>
</header>