<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Your Order Receipt</title>
</head>
<body style="margin: 0; padding: 0; background-color: #0b0f19; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; color: #ffffff; -webkit-text-size-adjust: none;">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="background-color: #0b0f19; padding: 40px 20px;">
        <tr>
            <td align="center">
                <table width="600" border="0" cellpadding="0" cellspacing="0" style="background-color: #111827; border: 1px solid rgba(255,255,255,0.05); border-radius: 16px; padding: 32px; box-shadow: 0 10px 25px rgba(0,0,0,0.3);">
                    
                    <tr>
                        <td align="center" style="padding-bottom: 24px; border-b: 1px solid rgba(255,255,255,0.05);">
                            <h1 style="margin: 0; font-size: 28px; font-weight: 900; color: #f97316; letter-spacing: -1px;">QLess Campus</h1>
                            <p style="margin: 4px 0 0 0; font-size: 14px; color: #9ca3af;">Thank you for dining with us!</p>
                        </td>
                    </tr>

                    <tr>
                        <td style="padding: 24px 0;">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <span style="font-size: 11px; font-weight: bold; color: #6b7280; text-transform: uppercase; letter-spacing: 1px;">Order Summary</span>
                                        <div style="font-size: 18px; font-weight: bold; color: #ffffff; margin-top: 4px;">Order #{{ $order->id }}</div>
                                    </td>
                                    <td align="right" style="vertical-align: bottom;">
                                        <div style="font-size: 13px; color: #9ca3af;">{{ $order->created_at->format('d M Y, h:i A') }}</div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>

                    <tr>
                        <td style="border-top: 1px solid rgba(255,255,255,0.05); padding-top: 16px;">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                @foreach($order->items as $item)
                                    <tr>
                                        <td style="padding: 10px 0; font-size: 14px; color: #d1d5db;">
                                            <span style="font-weight: bold; color: #ffffff; background-color: rgba(255,255,255,0.1); padding: 2px 6px; border-radius: 4px; margin-right: 8px;">{{ $item->quantity }}x</span>
                                            {{ $item->product->item_name }}
                                        </td>
                                        <td align="right" style="padding: 10px 0; font-size: 14px; color: #9ca3af; font-weight: 500;">
                                            Rs. {{ number_format($item->price * $item->quantity, 2) }}
                                        </td>
                                    </tr>
                                @endforeach
                            </table>
                        </td>
                    </tr>

                    <tr>
                        <td style="border-top: 1px solid rgba(255,255,255,0.05); margin-top: 16px; padding-top: 20px;">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="font-size: 14px; color: #9ca3af; font-weight: 500;">Payment Status</td>
                                    <td align="right" style="font-size: 14px; color: #10b981; font-weight: bold; text-transform: uppercase;">Paid & Fulfilled</td>
                                </tr>
                                <tr>
                                    <td style="font-size: 16px; color: #ffffff; font-weight: bold; padding-top: 12px;">Total Bill Paid</td>
                                    <td align="right" style="font-size: 22px; color: #f97316; font-weight: 900; padding-top: 12px;">
                                        Rs. {{ number_format($order->total_amount, 2) }}
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>

                    <tr>
                        <td align="center" style="border-top: 1px solid rgba(255,255,255,0.05); margin-top: 32px; padding-top: 24px;">
                            <p style="margin: 0; font-size: 12px; color: #4b5563; line-height: 1.5;">
                                If you did not make this purchase or notice errors on your statement receipt balance,<br>please contact the Campus Canteen Administrative Office immediately.
                            </p>
                        </td>
                    </tr>

                </table>
            </td>
        </tr>
    </table>
</body>
</html>