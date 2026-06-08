<?php

namespace App\Livewire;

use Livewire\Component;
use App\Models\Order;
use App\Jobs\SendOrderReceipt; 
use Illuminate\Support\Facades\Auth;

class LiveOrderBoard extends Component
{
    public $showOtpModal = false;
    public $verifyingOrderId = null;
    public $enteredOtp = '';
    public $otpError = '';

    // Standard status update
    public function updateOrderStatus($orderId, $newStatus)
    {
        $order = Order::find($orderId);
        if ($order && $order->canteen_id === Auth::user()->canteen_id) {
            $order->update(['status' => $newStatus]);
        }
    }

    // 1. Opens the popup when click "Hand to Student"
    public function promptOtp($orderId)
    {
        $this->verifyingOrderId = $orderId;
        $this->enteredOtp = '';
        $this->otpError = '';
        $this->showOtpModal = true;
    }

    // 2. Closes the popup
    public function closeOtpModal()
    {
        $this->showOtpModal = false;
        $this->verifyingOrderId = null;
    }

    // 3. Verifies the code
    public function verifyAndComplete()
    {
        $order = Order::find($this->verifyingOrderId);

        // Check if the typed OTP matches the database
        if ($order && $order->otp === $this->enteredOtp) {
            
            $order->update(['status' => 'completed']);
            
            \App\Jobs\SendOrderReceipt::dispatch($order);

            $this->closeOtpModal();
            
        } else {
            $this->otpError = 'Incorrect PIN. Please check with the student.';
        }
    }

    public function render()
    {
        $manager = Auth::user();
        
        $orders = Order::with(['user', 'items.product'])
                       ->where('canteen_id', $manager->canteen_id)
                       ->whereIn('status', ['pending', 'preparing', 'packing', 'ready'])
                       ->orderBy('created_at', 'asc')
                       ->get();

        return view('livewire.live-order-board', compact('orders'))
            ->layout('layouts.manager');
    }
}