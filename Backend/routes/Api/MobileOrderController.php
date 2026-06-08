<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MobileOrderController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        // 1. Fetch all parent orders for this student
        $orders = Order::where('user_id', $user->id)
            ->orderBy('created_at', 'desc')
            ->get();

        // 2. Map through each order and manually query its matching child food items
        $orders->map(function ($order) {
            $order->items = DB::table('order_items')
                ->join('products', 'order_items.product_id', '=', 'products.id')
                ->where('order_items.order_id', $order->id)
                ->select(
                    'products.item_name', 
                    'order_items.price', 
                    'order_items.quantity',
                    'products.image_path'
                )
                ->get();
            return $order;
        });

        // 3. Return the fully bundled nested data payload straight to Flutter
        return response()->json([
            'status' => 'success',
            'orders' => $orders
        ], 200);
    }

    public function store(Request $request)
    {
        // Verify orders can be created by this token
        if (! $request->user()->tokenCan('orders:create')) {
            return response()->json([
                'status' => 'error',
                'message' => 'Forbidden. Token lacks orders:create capability.'
            ], 403);
        }

        // verify the shopping cart request parameters payload
        $request->validate([
            'total_amount' => 'required|numeric',
            'items'        => 'required|array|min:1',
            'items.*.id'   => 'required|exists:products,id',
            'items.*.qty'  => 'required|integer|min:1',
        ]);

        $user = $request->user();

        // 3. Database Transaction: Insert order securely to prevent errors
        DB::beginTransaction();
        try {
            // Build parent order record
            $order = Order::create([
                'user_id'     => $user->id,
                'canteen_id'  => $user->canteen_id,
                'total_amount'=> $request->total_amount,
                'status'      => 'pending', 
                'otp'    => rand(1000, 9999), 
            ]);

            // Loop and attach specific individual food line items
            foreach ($request->items as $item) {
                // pull products price
                $product = Product::find($item['id']);

                DB::table('order_items')->insert([
                    'order_id'   => $order->id,
                    'product_id' => $item['id'],
                    'quantity'   => $item['qty'],
                    'price' => $product->price,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }

            DB::commit();

            return response()->json([
                'status'  => 'success',
                'message' => 'Order placed successfully. Sent to kitchen queue.',
                'order'   => [
                    'id'            => $order->id,
                    'total_amount'  => $order->total_amount,
                    'status'        => $order->status,
                    'otp'           => $order->otp
                ]
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'status'  => 'error',     
                'message' => 'Transaction failed. Order aborted.',
                'error'   => $e->getMessage()
            ], 500);
        }
    }
}