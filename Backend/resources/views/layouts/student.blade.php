<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>Student Portal - Qless Campus</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    @livewireStyles
</head>
<body class="font-sans antialiased bg-[#0f0f13] text-gray-100 flex h-screen overflow-hidden selection:bg-orange-500 selection:text-white">

    <x-side-nav>
        <p class="px-4 text-[10px] font-bold text-gray-500 uppercase tracking-widest mb-4">Campus Dining</p>

        <a href="{{ route('student.menu') }}"
           class="{{ request()->routeIs('student.menu') ? 'bg-orange-500/10 text-orange-400 border border-orange-500/20 shadow-inner' : 'text-gray-400 hover:bg-white/5 hover:text-white border border-transparent' }} flex items-center px-4 py-3.5 rounded-xl transition-all duration-200 group font-semibold text-sm">
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path></svg>
            Canteen Menu
        </a>

        <a href="{{ route('student.cart.view') }}"
           class="{{ request()->routeIs('student.cart.view') ? 'bg-orange-500/10 text-orange-400 border border-orange-500/20 shadow-inner' : 'text-gray-400 hover:bg-white/5 hover:text-white border border-transparent' }} flex items-center px-4 py-3.5 rounded-xl transition-all duration-200 group font-semibold text-sm mt-1">            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path></svg>
            My Cart
            <span class="ml-auto bg-orange-500 text-white text-[10px] font-bold w-5 h-5 flex items-center justify-center rounded-full shadow-md">
                {{ collect(session('cart'))->sum('quantity') }}
            </span>      
         </a>

        <a href="{{ route('student.orders') }}"
           class="{{ request()->routeIs('student.orders') ? 'bg-orange-500/10 text-orange-400 border border-orange-500/20 shadow-inner' : 'text-gray-400 hover:bg-white/5 hover:text-white border border-transparent' }} flex items-center px-4 py-3.5 rounded-xl transition-all duration-200 group font-semibold text-sm mt-1">            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
            Order History
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