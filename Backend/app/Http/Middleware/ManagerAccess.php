<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class ManagerAccess
{
    public function handle(Request $request, Closure $next): Response
    {
        // If the role is student, kick them safely back to the home page.
        if (auth()->check() && auth()->user()->role === 'student') {
            return redirect('/');
        }

        // If they are a manager or admin, let them proceed to the dashboard!
        return $next($request);
    }
}
