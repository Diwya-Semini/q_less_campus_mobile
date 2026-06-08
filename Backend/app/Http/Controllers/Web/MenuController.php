<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Product; 
use Illuminate\Support\Facades\Auth;

class MenuController extends Controller
{
    // 1. show menu items
    public function index()
    {
        $manager = Auth::user();
        $menuItems = Product::where('canteen_id', $manager->canteen_id)
                            ->orderBy('created_at', 'desc')
                            ->get();

        return view('canteen_manager.menu.index', compact('menuItems'));
    }

    // 2.create new item
    public function create()
    {
        return view('canteen_manager.menu.create');
    }

    // 3.store it into the database 
    public function store(Request $request)
    {
        $request->validate([
            'item_name' => 'required|string|max:255',
            'category' => 'required|string',
            'price' => 'required|numeric|min:0',
            'description' => 'nullable|string',
            'image_url' => 'nullable|string', 
        ]);

        $data = $request->all();
        $data['canteen_id'] = Auth::user()->canteen_id;
        $data['is_available'] = $request->has('is_available') ? 1 : 0;

        Product::create($data);

        return redirect()->route('manager.menu')->with('success', 'Menu item added successfully!');
    }

    // 4.edit product
    public function edit($id)
    {
        $menuItem = Product::where('canteen_id', Auth::user()->canteen_id)->findOrFail($id);
        return view('canteen_manager.menu.edit', compact('menuItem'));
    }

    // 5.update product
    public function update(Request $request, $id)
    {
        $menuItem = Product::where('canteen_id', Auth::user()->canteen_id)->findOrFail($id);

        $request->validate([
            'item_name' => 'required|string|max:255',
            'category' => 'required|string',
            'price' => 'required|numeric|min:0',
            'description' => 'nullable|string',
            'image_url' => 'nullable|string',
        ]);

        $data = $request->all();
        $data['is_available'] = $request->has('is_available') ? 1 : 0;

        $menuItem->update($data);

        return redirect()->route('manager.menu')->with('success', 'Menu item updated successfully!');
    }

    // 6.delete product
    public function destroy($id)
    {
        $menuItem = Product::where('canteen_id', Auth::user()->canteen_id)->findOrFail($id);
        $menuItem->delete();

        return redirect()->route('manager.menu')->with('success', 'Menu item deleted completely.');
    }
}