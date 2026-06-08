<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Auth;

class StudentMiddleware
{
    /**
     * Handle an incoming request.
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Check if logged in AND role is 'student'
        if (Auth::check() && Auth::user()->role === 'student') {
            return $next($request); // Welcome to the food court!
        }

        // If they aren't a student, kick them back to the default dashboard
        return redirect('/dashboard');
    }
}