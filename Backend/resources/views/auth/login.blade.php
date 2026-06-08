<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Q-Less Campus</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="bg-[#0f0f12] text-gray-100 font-sans antialiased min-h-screen flex items-center justify-center p-6">

    <div class="w-full max-w-md bg-[#16161a] border border-gray-800 rounded-3xl p-8 shadow-2xl">
        @if (session('status'))
            <div class="mb-4 bg-green-950/40 border border-green-800 text-green-400 p-4 rounded-xl text-sm animate-pulse">
                {{ session('status') }}
            </div>
        @endif

        @if (session('success'))
            <div class="mb-4 bg-green-950/40 border border-green-800 text-green-400 p-4 rounded-xl text-sm">
                {{ session('success') }}
            </div>
        @endif
        
        <div class="text-center mb-8 group">
            <div class="flex items-center justify-center gap-2 mb-2">
                <span class="w-4 h-4 rounded-full bg-orange-500 shadow-[0_0_15px_rgba(255,87,34,0.5)]"></span>
                <span class="text-3xl font-black tracking-widest text-white uppercase">Q-Less<span class="text-orange-500 font-medium lowercase">.campus</span></span>
            </div>
            <p class="text-gray-500 text-sm">Secure Multi-Tenant Gateway</p>
        </div>

        @if ($errors->any())
            <div class="mb-6 bg-red-900/30 border border-red-800 text-red-400 px-4 py-3 rounded-xl text-sm">
                <ul class="list-disc list-inside">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        <form method="POST" action="{{ route('login') }}">
            @csrf

            <div class="mb-5">
                <label for="email" class="block text-sm font-medium text-gray-400 mb-2">Campus Email</label>
                <input id="email" type="email" name="email" value="{{ old('email') }}" required autofocus autocomplete="username" 
                    class="w-full bg-[#1a1a1a] border border-gray-700 text-white rounded-xl focus:ring-orange-500 focus:border-orange-500 block p-3 transition">
            </div>

            <div class="mb-6">
                <label for="password" class="block text-sm font-medium text-gray-400 mb-2">Password</label>
                <input id="password" type="password" name="password" required autocomplete="current-password" 
                    class="w-full bg-[#1a1a1a] border border-gray-700 text-white rounded-xl focus:ring-orange-500 focus:border-orange-500 block p-3 transition">
            </div>

            <div class="flex items-center justify-between mb-8">
                <label for="remember_me" class="flex items-center cursor-pointer">
                    <input id="remember_me" type="checkbox" name="remember" class="rounded bg-gray-800 border-gray-700 text-orange-500 focus:ring-orange-500 focus:ring-offset-gray-900 w-4 h-4">
                    <span class="ml-2 text-sm text-gray-400">Remember me</span>
                </label>

                @if (Route::has('password.request'))
                    <a class="text-sm text-orange-500 hover:text-orange-400 transition" href="{{ route('password.request') }}">
                        Forgot password?
                    </a>
                @endif
            </div>

            <button type="submit" class="w-full bg-[#ff5722] hover:bg-[#e64a19] text-white font-bold py-3 px-4 rounded-xl transition duration-300 shadow-lg shadow-orange-500/20">
                Log In
            </button>

            <div class="mt-6 text-center text-sm border-t border-gray-800/60 pt-4">
            <span class="text-gray-500">Want to join the marketplace?</span>
            <a href="/vendor/register" class="text-orange-500 hover:text-orange-400 font-semibold transition ml-1">
                Register Your Canteen →
            </a>
        </div>
        </form>

    </div>

</body>
</html>