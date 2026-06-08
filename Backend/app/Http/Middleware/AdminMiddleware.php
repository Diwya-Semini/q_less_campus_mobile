<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Web\AdminController; 
class AdminMiddleware
{
    /**
     * Handle an incoming request.
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Check if their database role is specifically 'admin'
        if (Auth::check() && Auth::user()->role === 'admin') {
            return $next($request); // Let them through to the dashboard!
        }

        // If they aren't an admin, kick them back to the main router
        return redirect('/dashboard');
    }


    
}