@extends('layouts.manager')

@section('content')
<div class="max-w-7xl mx-auto pb-12">
    
    <div class="flex flex-col md:flex-row justify-between items-start md:items-end mb-8 gap-4">
        <div>
            <h1 class="text-3xl font-black text-white tracking-tight">Menu Management</h1>
            <p class="text-gray-400 mt-1">Add, edit, or remove items using Image URLs.</p>
        </div>
        <a href="{{ route('manager.menu.create') }}" class="bg-orange-600 hover:bg-orange-500 text-white font-bold py-2.5 px-5 rounded-xl transition duration-200 flex items-center shadow-[0_0_15px_rgba(234,88,12,0.3)]">
            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
            Add New Item
        </a>
    </div>

    <div class="bg-white/[0.02] border border-white/5 rounded-2xl overflow-hidden shadow-lg overflow-x-auto">
        <table class="w-full text-left border-collapse min-w-[600px]">
            <thead>
                <tr class="bg-black/20 border-b border-white/5 text-gray-400 text-xs uppercase tracking-wider">
                    <th class="p-4 font-bold">Item Name</th>
                    <th class="p-4 font-bold">Category</th>
                    <th class="p-4 font-bold">Price</th>
                    <th class="p-4 font-bold">Status</th>
                    <th class="p-4 font-bold text-right">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-white/5 text-sm">
                @forelse($menuItems ?? [] as $item)
                    <tr class="hover:bg-white/5 transition-colors {{ !$item->is_available ? 'bg-red-500/[0.02]' : '' }}">
                        <td class="p-4 flex items-center">
                            <div class="w-10 h-10 rounded-lg bg-gray-800 mr-3 border border-white/10 overflow-hidden shrink-0">
                                @if($item->image_url)
                                    <img src="{{ $item->image_url }}" alt="{{ $item->item_name }}" class="w-full h-full object-cover">
                                @else
                                    <div class="w-full h-full bg-orange-900/30 flex items-center justify-center text-orange-500 text-[10px] font-bold">No Img</div>
                                @endif
                            </div>
                            <span class="text-white font-bold">{{ $item->item_name }}</span>
                        </td>
                        <td class="p-4 text-gray-300">{{ $item->category }}</td>
                        <td class="p-4 text-white font-bold">Rs. {{ number_format($item->price, 2) }}</td>
                        <td class="p-4">
                            @if($item->is_available)
                                <span class="bg-green-500/10 text-green-400 border border-green-500/20 px-2.5 py-1 rounded-md text-xs font-bold">Available</span>
                            @else
                                <span class="bg-red-500/10 text-red-400 border border-red-500/20 px-2.5 py-1 rounded-md text-xs font-bold">Out of Stock</span>
                            @endif
                        </td>
                        <td class="p-4 text-right space-x-3">
                            <a href="{{ route('manager.menu.edit', $item->id) }}" class="text-gray-400 hover:text-orange-400 font-medium transition-colors">Edit</a>
                            <form action="{{ route('manager.menu.destroy', $item->id) }}" method="POST" class="inline-block" onsubmit="return confirm('Are you sure you want to delete this item?');">
                                @csrf
                                @method('DELETE')
                                <button type="submit" class="text-gray-400 hover:text-red-400 font-medium transition-colors">Delete</button>
                            </form>
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="5" class="p-8 text-center text-gray-500">
                            <p>No menu items found. Click "Add New Item" to get started.</p>
                        </td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>
</div>
@endsection