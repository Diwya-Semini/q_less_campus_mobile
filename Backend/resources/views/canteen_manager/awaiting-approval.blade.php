<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Account Pending Verification | QLess Campus</title>
    
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    
    <!-- Google Fonts for Modern Sans Interface -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
        }
    </style>
</head>
<body class="bg-[#0B0F19] antialiased">

    <!-- Top Action Bar with FIXED Secure POST Logout Form -->
    <div class="w-full flex justify-end p-4 max-w-7xl mx-auto">
        <form method="POST" action="/logout">
            @csrf <!-- Required for secure POST actions in Laravel -->
            <button type="submit" class="p-2 text-gray-500 hover:text-orange-500 hover:bg-orange-500/10 rounded-lg transition-all duration-200 cursor-pointer flex items-center gap-2 text-sm font-medium" title="Log Out">
                <span>Sign Out</span>
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                </svg>
            </button>
        </form>
    </div>

    <div class="min-h-[calc(100vh-80px)] flex flex-col items-center justify-center p-6 -mt-12">
        
        <!-- Success Toast Notification -->
        @if (session('status'))
            <div class="mb-6 max-w-md w-full bg-emerald-500/10 border border-emerald-500/20 rounded-2xl p-4 flex items-start gap-3 backdrop-blur-xl transition-all">
                <svg class="w-5 h-5 text-emerald-400 shrink-0 mt-0.5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
                <div>
                    <h4 class="text-sm font-bold text-emerald-400">Application Submitted</h4>
                    <p class="text-xs text-emerald-400/80 mt-0.5 leading-relaxed">
                        {{ session('status') }}
                    </p>
                </div>
            </div>
        @endif

        <!-- Main Card Container -->
        <div class="bg-white/[0.02] border border-white/5 rounded-3xl p-8 max-w-md w-full text-center backdrop-blur-2xl shadow-2xl transition-all duration-300 hover:border-white/10">
            
            <!-- Status Icon (Clock) -->
            <div class="w-16 h-16 bg-orange-500/10 border border-orange-500/20 text-orange-400 rounded-2xl flex items-center justify-center mx-auto mb-6 shadow-xl shadow-orange-500/5">
                <svg class="w-8 h-8" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6h4.5m4.5 0a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
            </div>
            
            <!-- Heading Content -->
            <h2 class="text-2xl font-black text-white tracking-tight">Account Pending Verification</h2>
            <p class="text-gray-400 text-sm mt-3 leading-relaxed px-2">
                Welcome to the QLess Campus network. Your facility profiling dashboard is locked until the university executive team reviews your credentials.
            </p>

            <!-- Elegant Divider Line -->
            <div class="my-6 border-t border-white/5 w-full"></div>

            <p class="text-xs text-gray-500 font-medium">
                Please check back later or contact admin support if verification takes longer than 24 hours.
            </p>
        </div>

    </div>

</body>
</html>