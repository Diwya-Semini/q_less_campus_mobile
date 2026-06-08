<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Q-Less Campus — Pre-order & Skip Canteen Queues</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:ital,wght@0,200..800;1,200..800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; }
        .bg-grid-pattern {
            background-size: 40px 40px;
            background-image: linear-gradient(to right, rgba(255, 255, 255, 0.015) 1px, transparent 1px),
                              linear-gradient(to bottom, rgba(255, 255, 255, 0.015) 1px, transparent 1px);
        }
    </style>
</head>
<body class="bg-[#080B11] text-slate-100 antialiased selection:bg-orange-500 selection:text-white overflow-x-hidden min-h-screen flex flex-col justify-between">

    <div class="absolute top-0 left-1/4 w-[500px] h-[500px] bg-orange-500/10 rounded-full blur-[120px] -z-20 pointer-events-none"></div>
    <div class="absolute top-[400px] right-1/4 w-[600px] h-[600px] bg-amber-600/5 rounded-full blur-[150px] -z-20 pointer-events-none"></div>
    <div class="absolute inset-0 bg-grid-pattern -z-30 pointer-events-none"></div>

    <nav class="sticky top-0 z-50 w-full border-b border-white/[0.05] bg-[#080B11]/70 backdrop-blur-xl">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-20 flex items-center justify-between">
            <div class="flex items-center gap-3 group cursor-pointer">
                <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-orange-500 to-amber-600 flex items-center justify-center font-extrabold text-white text-xl shadow-lg shadow-orange-500/20 group-hover:scale-105 transition duration-300">
                    Q
                </div>
                <div>
                    <span class="text-lg font-black tracking-tight text-white block">Q-Less</span>
                    <span class="text-[10px] font-bold text-orange-500 uppercase tracking-widest block -mt-1">Campus Hub</span>
                </div>
            </div>

            <div class="flex items-center gap-6">
                <span class="hidden md:flex items-center text-[11px] font-bold uppercase tracking-wider text-emerald-400 bg-emerald-500/5 border border-emerald-500/10 px-3 py-2 rounded-xl backdrop-blur-md">
                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500 mr-2 animate-pulse"></span>
                    Systems Operational
                </span>
                <a href="{{ route('login') }}" class="text-sm font-bold text-slate-400 hover:text-white transition duration-200">
                    Sign In
                </a>
                <a href="{{ route('register') }}" class="bg-white text-slate-950 hover:bg-slate-200 px-5 py-2.5 rounded-xl text-sm font-bold shadow-lg shadow-white/5 transition duration-200 transform active:scale-95">
                    Create Student Account
                </a>
            </div>
        </div>
    </nav>

    <main class="max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 pt-12 md:pt-20 flex-1">
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">
            
            <div class="lg:col-span-7 space-y-6 text-center lg:text-left">
                <div class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-orange-500/10 border border-orange-500/20 text-orange-400 text-xs font-bold tracking-wide uppercase">
                    Intelligent Multi-Tenant Dining Architecture
                </div>
                <h1 class="text-4xl sm:text-6xl font-extrabold text-white tracking-tight leading-[1.1]">
                    Ditch the wait.<br>
                    <span class="bg-gradient-to-r from-orange-400 via-amber-500 to-orange-500 bg-clip-text text-transparent">Order ahead.</span>
                </h1>
                <p class="text-slate-400 text-sm sm:text-base max-w-xl mx-auto lg:mx-0 leading-relaxed font-medium">
                    Pre-order directly from verified campus food courts, pick the ultimate time slot, and collect your order instantly upon arrival. Your short breaks shouldn't be wasted standing in line.
                </p>
                
                <div class="flex flex-col sm:flex-row items-center justify-center lg:justify-start gap-4 pt-4">
                    <a href="{{ route('vendor.register') }}" class="w-full sm:w-auto bg-white/[0.02] hover:bg-white/[0.05] border border-white/10 text-white font-bold text-sm px-8 py-4 rounded-xl backdrop-blur-md transition duration-200 text-center transform hover:-translate-y-0.5">
                        Register Canteen Facility
                    </a>
                </div>
            </div>

            <div class="lg:col-span-5 relative w-full flex justify-center lg:justify-end">
                <div class="relative w-full max-w-[420px] aspect-[4/5] rounded-[32px] border border-white/10 p-4 bg-[#0d121f]/60 backdrop-blur-2xl shadow-2xl overflow-hidden group">
                    <div class="absolute inset-0 bg-gradient-to-b from-orange-500/10 to-transparent opacity-0 group-hover:opacity-100 transition duration-500 pointer-events-none"></div>
                    <img src="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=600&q=80" 
                         alt="Premium Platform Interaction" 
                         class="w-full h-full object-cover rounded-[22px] brightness-90 contrast-105 group-hover:scale-[1.02] transition duration-700">
                </div>
            </div>
        </div>

        <div class="py-20 space-y-12">
            <div class="text-center max-w-2xl mx-auto space-y-2">
                <span class="text-xs font-black uppercase tracking-widest text-orange-500">Engineered For Performance</span>
                <h2 class="text-2xl sm:text-4xl font-extrabold text-white tracking-tight">How Q-Less Transforms Your Day</h2>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="bg-white/[0.01] border border-white/5 rounded-2xl p-6 hover:border-white/10 hover:bg-white/[0.02] transition duration-300 relative group">
                    <div class="w-12 h-12 rounded-xl bg-orange-500/10 border border-orange-500/20 flex items-center justify-center text-orange-400 mb-6 group-hover:scale-110 transition duration-300">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z"></path></svg>
                    </div>
                    <h3 class="text-lg font-bold text-white tracking-tight">Seamless Digital Menu</h3>
                    <p class="text-slate-400 text-xs mt-2 leading-relaxed">Browse dynamic dish availability registers, real-time prices, and current wait-times on any mobile device.</p>
                </div>

                <div class="bg-white/[0.01] border border-white/5 rounded-2xl p-6 hover:border-white/10 hover:bg-white/[0.02] transition duration-300 relative group">
                    <div class="w-12 h-12 rounded-xl bg-orange-500/10 border border-orange-500/20 flex items-center justify-center text-orange-400 mb-6 group-hover:scale-110 transition duration-300">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    </div>
                    <h3 class="text-lg font-bold text-white tracking-tight">Precision Scheduling</h3>
                    <p class="text-slate-400 text-xs mt-2 leading-relaxed">Select a tailored pickup window aligned exactly with your lectures. Your food prepares right on schedule.</p>
                </div>

                <div class="bg-white/[0.01] border border-white/5 rounded-2xl p-6 hover:border-white/10 hover:bg-white/[0.02] transition duration-300 relative group">
                    <div class="w-12 h-12 rounded-xl bg-orange-500/10 border border-orange-500/20 flex items-center justify-center text-orange-400 mb-6 group-hover:scale-110 transition duration-300">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"></path></svg>
                    </div>
                    <h3 class="text-lg font-bold text-white tracking-tight">Express Collection</h3>
                    <p class="text-slate-400 text-xs mt-2 leading-relaxed">Walk up to the dedicated Q-Less express counter, present your token ID, grab your meal, and carry on.</p>
                </div>
            </div>
        </div>
    </main>

    <footer class="border-t border-white/[0.05] bg-black/20 text-slate-500 text-xs py-10">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex flex-col md:flex-row items-center justify-between gap-6">
            <div class="flex items-center gap-2 font-medium text-slate-400">
                <span>© 2026 Q-Less Campus. Deployed under AgTech Zero-Error Framework standards.</span>
            </div>
            <div class="flex gap-6 font-semibold text-slate-400">
                <a href="#" class="hover:text-orange-400 transition">University Logistics</a>
                <a href="#" class="hover:text-orange-400 transition">Vendor Node Rules</a>
                <a href="#" class="hover:text-orange-400 transition">Privacy Architecture</a>
            </div>
        </div>
    </footer>

</body>
</html>