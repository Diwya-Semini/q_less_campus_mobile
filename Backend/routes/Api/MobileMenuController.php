<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;

class MobileMenuController extends Controller
{
    public function index(Request $request)
    {
        // check if token has the right permission scope
        if (! $request->user()->tokenCan('menu:view')) {
            return response()->json([
                'status' => 'error',
                'message' => 'Forbidden. Token lacks menu:view capabilities.'
            ], 403);
        }

        // collect canteen ID directly from the authenticated user token
        $canteenId = $request->user()->canteen_id;

        if (! $canteenId) {
            return response()->json([
                'status' => 'error',
                'message' => 'This student account is not linked to any campus canteen node.'
            ], 422);
        }

        // collect only available food products matching this canteen scope
        $menuItems = Product::where('canteen_id', $canteenId)
            ->where('is_available', 1)
            ->select('id', 'item_name', 'description', 'price', 'image_url', 'category')
            ->get();

        return response()->json([
            'status' => 'success',
            'canteen_id' => $canteenId,
            'count' => $menuItems->count(),
            'menu' => $menuItems
        ], 200);
    }
}