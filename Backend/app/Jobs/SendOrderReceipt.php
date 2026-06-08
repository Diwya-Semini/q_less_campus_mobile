<?php

namespace App\Jobs;

use App\Models\Order;
use App\Models\User;
use App\Mail\OrderReceiptMail;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;

class SendOrderReceipt implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $orderId;

    public function __construct($order)
    {
        $this->orderId = is_object($order) ? $order->id : $order;
    }

    public function handle(): void
    {
        // 1. Explicitly pull the order fresh from the database with its items and products loaded
        $order = Order::with(['items.product'])->find($this->orderId);

        if (!$order) {
            Log::error("SendOrderReceipt Queue Error: Order #{$this->orderId} not found in database.");
            return;
        }

        // 2. Safely locate the student profile user
        $user = User::find($order->user_id);

        if (!$user || !$user->email) {
            Log::error("SendOrderReceipt Queue Error: User email missing or invalid for Order #{$order->id}");
            return;
        }

        // 3. Dispatch the Mailable template layout
        Mail::to($user->email)->send(new OrderReceiptMail($order));
    }
}