<x-guest-layout>
    <div class="max-w-md mx-auto bg-[#16161a] rounded-3xl border border-gray-800 p-8 shadow-2xl">
        
        <div class="mb-6 text-center">
            <span class="text-xs font-bold text-orange-500 uppercase tracking-widest">SaaS Marketplace Platform</span>
            <h1 class="text-2xl font-black text-white mt-1">Register Your Canteen</h1>
            <p class="text-sm text-gray-500 mt-1">Setup your branch endpoint for the campus network.</p>
        </div>

        @if ($errors->any())
            <div class="mb-5 bg-red-900/40 border border-red-500/50 text-red-400 p-4 rounded-xl text-sm">
                <div class="font-bold mb-1 uppercase tracking-wide text-xs">Registration Blocked:</div>
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        <form action="/register" method="POST" class="space-y-4">
            @csrf

            <div>
                <label class="block text-xs font-semibold text-gray-400 uppercase tracking-wider mb-2">Manager Full Name</label>
                <input type="text" name="name" value="{{ old('name') }}" required class="w-full bg-[#1a1a1a] border border-gray-800 rounded-xl px-4 py-2.5 text-sm text-white focus:outline-none focus:border-orange-500 transition">
            </div>

            <div>
                <label class="block text-xs font-semibold text-gray-400 uppercase tracking-wider mb-2">Official Email</label>
                <input type="email" name="email" value="{{ old('email') }}" required class="w-full bg-[#1a1a1a] border border-gray-800 rounded-xl px-4 py-2.5 text-sm text-white focus:outline-none focus:border-orange-500 transition">
            </div>

            <div>
                <label class="block text-xs font-semibold text-gray-400 uppercase tracking-wider mb-2">Target Campus Allocation</label>
                <select name="location" required class="w-full bg-[#1a1a1a] border border-gray-800 rounded-xl px-4 py-2.5 text-sm text-gray-300 focus:outline-none focus:border-orange-500 transition">
                    <option value="" disabled selected>Select your campus...</option>
                    <option value="APIIT Main">APIIT - Main Building</option>
                    <option value="SLIIT Cafe">SLIIT - Faculty Café</option>
                    <option value="SLIIT Main">SLIIT - Student Pavilion</option>
                    <option value="NSBM Green Uni">NSBM - Green University</option>
                    <option value="IIT Wellawatte">IIT - Wellawatte Campus</option>
                    <option value="UCSC">UCSC - Main Canteen</option>
                </select>
            </div>

            <div>
                <label class="block text-xs font-semibold text-gray-400 uppercase tracking-wider mb-2">Canteen Outlet Name</label>
                <input type="text" name="canteen_name" value="{{ old('canteen_name') }}" placeholder="ex: Royal Taste Kitchen" required class="w-full bg-[#1a1a1a] border border-gray-800 rounded-xl px-4 py-2.5 text-sm text-white focus:outline-none focus:border-orange-500 transition">
            </div>

            <div class="grid grid-cols-2 gap-3">
                <div>
                    <label class="block text-xs font-semibold text-gray-400 uppercase tracking-wider mb-2">Password</label>
                    <input type="password" name="password" required class="w-full bg-[#1a1a1a] border border-gray-800 rounded-xl px-4 py-2.5 text-sm text-white focus:outline-none focus:border-orange-500 transition">
                </div>
                <div>
                    <label class="block text-xs font-semibold text-gray-400 uppercase tracking-wider mb-2">Confirm</label>
                    <input type="password" name="password_confirmation" required class="w-full bg-[#1a1a1a] border border-gray-800 rounded-xl px-4 py-2.5 text-sm text-white focus:outline-none focus:border-orange-500 transition">
                </div>
            </div>

            <button type="submit" class="w-full bg-orange-500 hover:bg-orange-400 text-white font-bold py-3 rounded-xl transition duration-300 mt-6 shadow-lg shadow-orange-500/20">
                Submit Onboarding Application
            </button>
        </form>

        <div class="mt-6 text-center text-sm">
            <a href="/login" class="text-gray-500 hover:text-white transition">Already have an account? Log In</a>
        </div>
    </div>
</x-guest-layout>