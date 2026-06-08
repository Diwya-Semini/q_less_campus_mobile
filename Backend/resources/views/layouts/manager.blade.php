<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>Manager Portal - Qless Campus</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    @livewireStyles
</head>
<body class="font-sans antialiased bg-[#0f0f13] text-gray-100 flex h-screen overflow-hidden selection:bg-orange-500 selection:text-white">

    <x-side-nav>
        <p class="px-4 text-[10px] font-bold text-gray-500 uppercase tracking-widest mb-4">Canteen Operations</p>

        <a href="{{ route('manager.dashboard') }}"
           class="{{ request()->routeIs('manager.dashboard') ? 'bg-orange-500/10 text-orange-400 border border-orange-500/20 shadow-inner' : 'text-gray-400 hover:bg-white/5 hover:text-white border border-transparent' }} flex items-center px-4 py-3.5 rounded-xl transition-all duration-200 group font-semibold text-sm">
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
            Dashboard
        </a>

        <a href="{{ route('manager.orders') }}"
           class="{{ request()->routeIs('manager.orders') ? 'bg-orange-500/10 text-orange-400 border border-orange-500/20 shadow-inner' : 'text-gray-400 hover:bg-white/5 hover:text-white border border-transparent' }} flex items-center px-4 py-3.5 rounded-xl transition-all duration-200 group font-semibold text-sm mt-1">
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path></svg>
            Live Orders
        </a>

        <a href="{{ route('manager.menu') }}"
           class="{{ request()->routeIs('manager.menu') ? 'bg-orange-500/10 text-orange-400 border border-orange-500/20 shadow-inner' : 'text-gray-400 hover:bg-white/5 hover:text-white border border-transparent' }} flex items-center px-4 py-3.5 rounded-xl transition-all duration-200 group font-semibold text-sm mt-1">
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 10h16M4 14h16M4 18h16"></path></svg>
            Menu Management
        </a>

        <div class="my-4 border-t border-white/5 mx-4"></div>

        <a href="{{ route('manager.settings') }}"
           class="{{ request()->routeIs('manager.settings') ? 'bg-orange-500/10 text-orange-400 border border-orange-500/20 shadow-inner' : 'text-gray-400 hover:bg-white/5 hover:text-white border border-transparent' }} flex items-center px-4 py-3.5 rounded-xl transition-all duration-200 group font-semibold text-sm">
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>
            Settings
        </a>
    </x-side-nav>

    <main class="flex-1 h-screen overflow-y-auto relative custom-scrollbar">
        <div class="p-4 md:p-8">
            
            @if(session('success'))
                <div class="mb-6 bg-green-500/10 border border-green-500/20 text-green-400 px-4 py-3 rounded-xl flex items-center shadow-lg">
                    <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>
                    {{ session('success') }}
                </div>
            @endif

            @yield('content')
            
            {{ $slot ?? '' }}
        </div>
    </main>

    @livewireScripts
    <style>
        .custom-scrollbar::-webkit-scrollbar { width: 6px; }
        .custom-scrollbar::-webkit-scrollbar-track { background: transparent; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: #2d2d35; border-radius: 10px; }
        .custom-scrollbar::-webkit-scrollbar-thumb:hover { background: #3d3d45; }
    </style>
</body>
</html>