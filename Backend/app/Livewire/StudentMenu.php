<?php

namespace App\Livewire;

use Livewire\Component;
use App\Models\Product;
use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Support\Facades\Auth;

class StudentMenu extends Component
{
    public $cart = [];
    public $canteenId = 2;
    public $generatedOtp = null;

    public function addToCart($productId)
    {
        $product = Product::find($productId);
        
        if (!$product) return;

        if (isset($this->cart[$productId])) {
            $this->cart[$productId]['quantity']++;
        } else {
            $this->cart[$productId] = [
                'id' => $product->id,
                'name' => $product->item_name,
                'price' => $product->price,
                'quantity' => 1,
            ];
        }
        
        $this->generatedOtp = null;
    }

    public function removeFromCart($productId)
    {
        if (isset($this->cart[$productId])) {
            $this->cart[$productId]['quantity']--;
            if ($this->cart[$productId]['quantity'] <= 0) {
                unset($this->cart[$productId]);
            }
        }
    }

    // Calculated Property for Total Order Value
    public function getTotalProperty()
    {
        $total = 0;
        foreach ($this->cart as $item) {
            $total += $item['price'] * $item['quantity'];
        }
        return $total;
    }

    public function checkout()
    {
        if (empty($this->cart)) return;

        // 1. Generate a secure random otp
        $otp = rand(1000, 9999);

        // 2. Create parent entry in orders table
        $order = Order::create([
            'user_id' => Auth::id(),
            'canteen_id' => $this->canteenId, 
            'total_amount' => $this->total,
            'status' => 'pending',
            'otp' => $otp,
        ]);

        // 3. Loop through cart arrays and build individual relationship items rows
        foreach ($this->cart as $item) {
            OrderItem::create([
                'order_id' => $order->id,
                'product_id' => $item['id'],
                'quantity' => $item['quantity'],
                'price_at_time' => $item['price'], 
            ]);
        }

        // 4. Reset the cart basket array
        $this->cart = [];

        // 5. Publish OTP property onto the blade component parameters
        $this->generatedOtp = $otp;
    }

    public function render()
    {
        // Pull only products belonging to canteen_id that are marked active
        $products = Product::where('is_available', 1)
                           ->where('canteen_id', $this->canteenId)
                           ->get();

        return view('livewire.student-menu', compact('products'))->layout('layouts.student');
    }

    public function history()
    {
        // 1. Fetch only the authenticated student's orders
        $orders = Order::where('user_id', Auth::id())
                       ->with(['items.product'])
                       ->orderBy('created_at', 'desc')
                       ->get();

        // 2. Compact 'orders' to match Blade view variable names exactly
        return view('student.orders.history', compact('orders'));
    }
}