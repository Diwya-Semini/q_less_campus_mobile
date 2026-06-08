<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class DashboardController extends Controller
{
    // 1. Live Queue Screen
    public function index()
    {
        $pendingOrders = Order::with(['user', 'items.product'])
            ->where('status', 'pending')
            ->orderBy('created_at', 'asc')
            ->get();

        return view('canteen_manager.manager', compact('pendingOrders'));
    }

    // 2. Complete an Order
    public function markReady(Order $order)
    {
        $order->update(['status' => 'ready']);
        return redirect()->back()->with('success', 'Order #' . $order->queue_number . ' is ready for pickup!');
    }

    // 3. Order History
    public function history()
    {
        $completedOrders = Order::with(['user', 'items.product'])
            ->whereIn('status', ['ready', 'completed'])
            ->orderBy('updated_at', 'desc')
            ->paginate(15); 

        return view('canteen_manager.history', compact('completedOrders'));
    }

    // 4. Settings View
    public function settings()
    {
        $isOpen = Cache::get('canteen_open', true);
        return view('canteen_manager.settings', compact('canteen'));
    }

    // 5. Toggle Store Status
    public function toggleStore(Request $request)
    {
        $currentState = Cache::get('canteen_open', true);
        Cache::put('canteen_open', !$currentState);

        $statusMessage = !$currentState ? 'Canteen is now OPEN for student orders.' : 'Canteen is now CLOSED.';
        return redirect()->back()->with('success', $statusMessage);
    }
}