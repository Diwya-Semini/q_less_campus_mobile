<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>Command Center - Qless Campus</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    @livewireStyles
</head>
<body class="font-sans antialiased bg-[#0f0f13] text-gray-100 flex h-screen overflow-hidden selection:bg-orange-500 selection:text-white">

    <x-side-nav>
        <p class="px-4 text-[10px] font-bold text-gray-500 uppercase tracking-widest mb-4">Command Center</p>

        <a href="{{ route('admin.dashboard') }}"
           class="{{ request()->routeIs('admin.dashboard') ? 'bg-orange-500/10 text-orange-400 border border-orange-500/20 shadow-inner' : 'text-gray-400 hover:bg-white/5 hover:text-white border border-transparent' }} flex items-center px-4 py-3.5 rounded-xl transition-all duration-200 group font-semibold text-sm">
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path></svg>
            Network Canteens
        </a>

        <a href="{{ route('admin.canteens.create') }}"
           class="{{ request()->routeIs('admin.canteens.create') ? 'bg-orange-500/10 text-orange-400 border border-orange-500/20 shadow-inner' : 'text-gray-400 hover:bg-white/5 hover:text-white border border-transparent' }} flex items-center px-4 py-3.5 rounded-xl transition-all duration-200 group font-semibold text-sm mt-1">
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
            Deploy Canteen
        </a>

        <a href="{{ route('admin.managers') }}"
           class="{{ request()->routeIs('admin.managers') ? 'bg-orange-500/10 text-orange-400 border border-orange-500/20 shadow-inner' : 'text-gray-400 hover:bg-white/5 hover:text-white border border-transparent' }} flex items-center px-4 py-3.5 rounded-xl transition-all duration-200 group font-semibold text-sm mt-1">
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path></svg>
            Platform Managers
        </a>
    </x-side-nav>

    <main class="flex-1 h-screen overflow-y-auto relative custom-scrollbar">
        <div class="p-4 md:p-8">
            
            @if(session('success'))
                <div class="mb-6 bg-green-500/10 border border-green-500/20 text-green-400 px-4 py-3 rounded-xl flex items-center shadow-lg backdrop-blur-md">
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