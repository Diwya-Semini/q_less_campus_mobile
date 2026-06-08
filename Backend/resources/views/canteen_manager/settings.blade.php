@extends('layouts.manager')

@section('content')
<div class="max-w-4xl mx-auto pb-12">
    
    <div class="mb-8">
        <h1 class="text-3xl font-black text-white tracking-tight">Canteen Settings</h1>
        <p class="text-gray-400 mt-1">Manage your operational details and account preferences.</p>
    </div>

    <div class="bg-white/[0.02] border border-white/5 rounded-2xl p-6 md:p-8 backdrop-blur-xl shadow-lg">
        <form>
            <h3 class="text-lg font-black text-white mb-4 border-b border-white/10 pb-2">Business Profile</h3>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                <div>
                    <label class="block text-sm font-bold text-gray-400 mb-2">Canteen Name</label>
                    <input type="text" value="Main Canteen" class="w-full px-4 py-3 bg-[#1a1a21] border border-white/5 rounded-xl text-white focus:outline-none focus:border-orange-500 transition-colors">
                </div>
                <div>
                    <label class="block text-sm font-bold text-gray-400 mb-2">Contact Number</label>
                    <input type="text" value="077 123 4567" class="w-full px-4 py-3 bg-[#1a1a21] border border-white/5 rounded-xl text-white focus:outline-none focus:border-orange-500 transition-colors">
                </div>
            </div>

            <h3 class="text-lg font-black text-white mb-4 border-b border-white/10 pb-2 mt-10">Operational Status</h3>
            
            <div class="mb-6 flex items-start">
                <div class="flex items-center h-5">
                    <input type="checkbox" checked class="w-5 h-5 text-orange-500 rounded border-white/10 bg-[#1a1a21] focus:ring-orange-500 focus:ring-offset-gray-900 cursor-pointer">
                </div>
                <div class="ml-3 text-sm">
                    <label class="text-white font-bold cursor-pointer">Accepting New Orders</label>
                    <p class="text-gray-500 mt-1">Turn this off to temporarily hide your canteen from the student app (e.g., during rush hour or emergencies).</p>
                </div>
            </div>

            <div class="mt-8 flex justify-end pt-6 border-t border-white/5">
                <button type="button" class="bg-orange-600 hover:bg-orange-500 text-white font-bold py-3 px-8 rounded-xl transition duration-200 shadow-lg">
                    Save Changes
                </button>
            </div>
        </form>
    </div>
</div>
@endsection