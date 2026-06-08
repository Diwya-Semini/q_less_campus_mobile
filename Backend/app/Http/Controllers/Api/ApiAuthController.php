<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class ApiAuthController extends Controller
{
    // secure login
    public function login(Request $request)
    {
        $request->validate([
            'email'       => 'required|email',
            'password'    => 'required',
            'device_name' => 'required|string', 
        ]);

        $user = User::where('email', $request->email)->first();

        // 1. checks credentials securely via Bcrypt hashing hashes
        if (! $user || ! Hash::check($request->password, $user->password)) {
            return response()->json([
                'status'  => 'error',
                'message' => 'The credentials provided do not match our campus database records.'
            ], 401);
        }

        // 2. check if the role is student or denies access
        if ($user->role !== 'student') {
            return response()->json([
                'status'  => 'error',
                'message' => 'Access Denied. This mobile system is strictly reserved for student accounts.'
            ], 403);
        }

        // 3. strict limitations directly into the digital keycard
        $abilities = ['menu:view', 'orders:create', 'profile:update'];

        // 4. creates the secure token with device tracking signatures
        $token = $user->createToken($request->device_name, $abilities)->plainTextToken;

        return response()->json([
            'status'  => 'success',
            'message' => 'Secure API handshake established.',
            'token'   => $token, 
            'user'    => [
                'id'         => $user->id,
                'name'       => $user->name,
                'email'      => $user->email,
                'canteen_id' => $user->canteen_id
            ]
        ], 200);
    }

    // logout
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'Active session token has been securely revoked.'
        ], 200);
    }

    // log out from all the devices
    public function logoutAll(Request $request)
    {
        $request->user()->tokens()->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'All active device sessions terminated successfully.'
        ], 200);
    }
}