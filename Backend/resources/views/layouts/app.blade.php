<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Qless Campus SaaS') }} - Command Center</title>

    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="font-sans antialiased bg-[#0f0f13] text-gray-100 selection:bg-orange-500 selection:text-white">
    <div class="min-h-screen">
        
        <nav class="bg-[#0f0f13]/80 backdrop-blur-md border-b border-white/5 sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between h-16">
                    
                    <div class="flex">
                        <div class="flex items-center">
                            <div class="w-8 h-8 bg-gradient-to-br from-orange-400 to-orange-600 rounded-lg flex items-center justify-center mr-3 shadow-lg shadow-orange-500/20">
                                <span class="text-white font-bold text-xl leading-none">Q</span>
                            </div>
                            <span class="text-gray-100 font-semibold tracking-wide text-lg">System<span class="text-gray-500 font-normal">Admin</span></span>
                        </div>

                        <div class="hidden sm:-my-px sm:ml-10 sm:flex sm:space-x-8">
                            <a href="{{ route('admin.dashboard') }}" class="{{ request()->routeIs('admin.dashboard') ? 'border-orange-500 text-white' : 'border-transparent text-gray-400 hover:text-gray-200 hover:border-gray-600' }} inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium transition-colors duration-200">
                                Canteen Approvals
                            </a>
                            <a href="{{ route('admin.managers') }}" class="{{ request()->routeIs('admin.managers') ? 'border-orange-500 text-white' : 'border-transparent text-gray-400 hover:text-gray-200 hover:border-gray-600' }} inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium transition-colors duration-200">
                                Platform Managers
                            </a>
                        </div>
                    </div>

                    <div class="flex items-center">
                        <form method="POST" action="{{ route('logout') }}">
                            @csrf
                            <button type="submit" class="text-sm font-medium text-gray-400 hover:text-white transition duration-200 px-4 py-2 rounded-lg border border-transparent hover:border-white/10 hover:bg-white/5">
                                Log Out
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </nav>

        <main class="py-8">
            {{ $slot }}
        </main>

    </div>
</body>
</html>