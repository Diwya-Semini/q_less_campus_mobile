<?php

use App\Http\Controllers\Api\ApiAuthController;
use App\Http\Controllers\Api\MobileMenuController;
use App\Http\Controllers\Api\MobileOrderController;
use Illuminate\Support\Facades\Route;

// 1. public end api endpoints
Route::post('/login', [ApiAuthController::class, 'login']);


// 2. secured end points
Route::middleware('auth:sanctum')->group(function () {
    
    // logouts
    Route::post('/logout', [ApiAuthController::class, 'logout']);
    Route::post('/logout-all', [ApiAuthController::class, 'logoutAll']);

    // garded end points
    Route::get('/menu', [MobileMenuController::class, 'index']);      
    Route::post('/orders', [MobileOrderController::class, 'store']);   

});