@extends('layouts.manager')

@section('content')
<div class="max-w-3xl mx-auto pb-12">
    
    <div class="mb-8 flex items-center gap-4">
        <a href="{{ route('manager.menu') }}" class="w-10 h-10 bg-white/5 hover:bg-white/10 rounded-xl flex items-center justify-center text-gray-400 hover:text-white transition-colors border border-white/5">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path></svg>
        </a>
        <div>
            <h1 class="text-3xl font-black text-white tracking-tight">Edit Item</h1>
        </div>
    </div>

    <div class="bg-white/[0.02] border border-white/5 rounded-2xl p-6 md:p-8 backdrop-blur-xl shadow-lg">
        <form action="{{ route('manager.menu.update', $menuItem->id) }}" method="POST">
            @csrf
            @method('PUT')
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                <div class="md:col-span-2">
                    <label class="block text-sm font-bold text-gray-400 mb-2">Item Name <span class="text-orange-500">*</span></label>
                    <input type="text" name="item_name" value="{{ old('item_name', $menuItem->item_name) }}" required class="w-full px-4 py-3 bg-[#1a1a21] border border-white/5 rounded-xl text-white focus:outline-none focus:border-orange-500 transition-colors">
                </div>

                <div>
                    <label class="block text-sm font-bold text-gray-400 mb-2">Category <span class="text-orange-500">*</span></label>
                    <select name="category" required class="w-full px-4 py-3 bg-[#1a1a21] border border-white/5 rounded-xl text-white focus:outline-none focus:border-orange-500 transition-colors appearance-none">
                        <option value="Mains" {{ $menuItem->category === 'Mains' ? 'selected' : '' }}>Mains</option>
                        <option value="Snacks" {{ $menuItem->category === 'Snacks' ? 'selected' : '' }}>Snacks</option>
                        <option value="Drinks" {{ $menuItem->category === 'Drinks' ? 'selected' : '' }}>Drinks</option>
                        <option value="Pastry" {{ $menuItem->category === 'Pastry' ? 'selected' : '' }}>Pastry</option>
                    </select>
                </div>

                <div>
                    <label class="block text-sm font-bold text-gray-400 mb-2">Price (Rs.) <span class="text-orange-500">*</span></label>
                    <input type="number" name="price" value="{{ old('price', $menuItem->price) }}" step="0.01" required class="w-full px-4 py-3 bg-[#1a1a21] border border-white/5 rounded-xl text-white focus:outline-none focus:border-orange-500 transition-colors">
                </div>

                <div class="md:col-span-2">
                    <label class="block text-sm font-bold text-gray-400 mb-2">Description</label>
                    <textarea name="description" rows="3" class="w-full px-4 py-3 bg-[#1a1a21] border border-white/5 rounded-xl text-white focus:outline-none focus:border-orange-500 transition-colors">{{ old('description', $menuItem->description) }}</textarea>
                </div>

                <div class="md:col-span-2">
                    <label class="block text-sm font-bold text-gray-400 mb-2">Image URL</label>
                    @if($menuItem->image_url)
                        <div class="mb-4 w-16 h-16 rounded-lg overflow-hidden border border-white/10">
                            <img src="{{ $menuItem->image_url }}" class="w-full h-full object-cover">
                        </div>
                    @endif
                    <input type="url" name="image_url" value="{{ old('image_url', $menuItem->image_url) }}" placeholder="https://example.com/image.jpg" class="w-full px-4 py-3 bg-[#1a1a21] border border-white/5 rounded-xl text-white focus:outline-none focus:border-orange-500 transition-colors">
                </div>

                <div class="md:col-span-2 flex items-center mt-2">
                    <input type="hidden" name="is_available" value="0">
                    <input type="checkbox" name="is_available" id="is_available" value="1" {{ $menuItem->is_available ? 'checked' : '' }} class="w-5 h-5 text-orange-500 rounded border-white/10 bg-[#1a1a21] focus:ring-orange-500 focus:ring-offset-gray-900 cursor-pointer">
                    <label for="is_available" class="ml-3 text-white font-bold cursor-pointer">Item is currently available for order</label>
                </div>
            </div>

            <div class="mt-8 flex justify-end pt-6 border-t border-white/5">
                <button type="submit" class="bg-orange-600 hover:bg-orange-500 text-white font-black py-3 px-8 rounded-xl transition duration-200 shadow-[0_0_15px_rgba(234,88,12,0.3)]">
                    Update Menu Item
                </button>
            </div>
        </form>
    </div>
</div>
@endsection