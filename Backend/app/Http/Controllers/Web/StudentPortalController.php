<?php 

namespace App\Http\Controllers\Web; 

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;

class StudentPortalController extends Controller
{
    public function index()
    {
        return $this->menu();
    }
    
    // 1.redirect to assigned canten
    public function menu(Request $request)
    {
        $user = auth()->user();
        
        // get available food 
        $query = Product::where('canteen_id', $user->canteen_id)
                        ->where('is_available', 1);

        // Search Filter 
        if ($request->filled('search')) {
            $query->where('item_name', 'LIKE', '%' . $request->search . '%');
        }

        //  Category Filter 
        if ($request->filled('category') && $request->category !== 'All') {
            $query->where('category', $request->category);
        }

        // Finally, fetch the filtered results from the database
        $products = $query->get();
        
        $itemCount = collect(session()->get('cart', []))->sum('quantity');

        $currentCategory = $request->category ?? 'All';
        $currentSearch = $request->search ?? '';

        return view('student.menu', compact('products', 'itemCount', 'currentCategory', 'currentSearch'));
    }

    // 2. add cart to session cart
    public function addToCart(Request $request, $id)
    {
        $product = Product::findOrFail($id);
        $cart = session()->get('cart', []);

        // if item is already in cart, just add to the quantity
        if(isset($cart[$id])) {
            $cart[$id]['quantity']++;
        } else {
            $cart[$id] = [
                "name" => $product->item_name,
                "quantity" => 1,
                "price" => $product->price,
                "image" => $product->image_url
            ];
        }

        session()->put('cart', $cart);
        return redirect()->back()->with('success', $product->item_name . ' added to your cart!');
    }

    // 3. view cart item page
    public function viewCart()
    {
        $cart = session()->get('cart', []);
        return view('student.cart', compact('cart'));
    }

    // 4. final check out
    public function checkout(Request $request)
    {
        $cart = session()->get('cart');
        if(!$cart) {
            return redirect()->back()->with('error', 'Your cart is empty!');
        }

        $user = auth()->user();
        $totalAmount = 0;
        foreach($cart as $item) {
            $totalAmount += $item['price'] * $item['quantity'];
        }

        // Database Transaction
        DB::transaction(function () use ($cart, $user, $totalAmount) {
            $order = Order::create([
                'user_id' => $user->id,
                'canteen_id' => $user->canteen_id,
                'total_amount' => $totalAmount,
                'status' => 'pending',
                'otp' => rand(1000, 9999) 
            ]);

            foreach($cart as $id => $item) {
                OrderItem::create([
                    'order_id' => $order->id,
                    'product_id' => $id,
                    'quantity' => $item['quantity'],
                    'price' => $item['price']
                ]);
            }
        });

        // Clear the session cart after a successful transaction database entry
        session()->forget('cart');
        
        return redirect()->route('student.orders')->with('success', 'Order sent to the kitchen!');
    }

    
    // 5. show order history and live ticket
    public function history()
    {
        $user = auth()->user();

        $orders = Order::with(['items.product'])
                       ->where('user_id', $user->id)
                       ->orderBy('created_at', 'desc')
                       ->get();

        return view('student.orders', compact('orders'));
    }

    
}