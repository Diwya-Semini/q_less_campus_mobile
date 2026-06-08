<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Canteen;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class VendorRegisterController extends Controller
{
    // show registration form
    public function showRegistrationForm()
    {
        return view('auth.register'); 
    }

    // process registration and create a multi tenant end point
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
            'location' => 'required|string|max:255',      
            'canteen_name' => 'required|string|max:255',   
        ]);

        // db transcation wrapper
        DB::transaction(function () use ($request) {
            
            // Create the new Canteen outlet 
            $fullCanteenName = $request->location . ' - ' . $request->canteen_name;
            
            $canteen = Canteen::create([
                'name' => $fullCanteenName,
                'location' => $request->location,
                'operating_hours' => '8:00 AM - 6:00 PM', 
                'is_open' => 0,                           
            ]);

            // get the id and attached to the manager
            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'role' => 'manager',
                'approval_status' => 'pending',           
                'canteen_id' => $canteen->id,             
            ]);

            // authenticate them into their pending session view
            auth()->login($user);
        });

        // Hand control off to the routing traffic cop middleware
        return redirect('/dashboard')->with('status', 'Registration successful! Your application has been submitted to the university administrator for approval.');
    }
}