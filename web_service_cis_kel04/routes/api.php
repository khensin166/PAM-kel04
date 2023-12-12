<?php

use App\Http\Controllers\Baak\AuthenticationController as BaakAuthenticationController;
use App\Http\Controllers\ik\IzinKeluarController;
use App\Http\Controllers\Mahasiswa\AuthenticationController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::post('/ik/store', [IzinKeluarController::class, 'store'])->middleware(['auth:sanctum', 'abilities:mahasiswa']);
Route::get('/ik', [IzinKeluarController::class, 'index'])->middleware(['auth:sanctum', 'abilities:mahasiswa']);

Route::get('/test', function () {
    return  response([
        'message' => 'Hello World!'
    ], 200);
});

Route::post('register', [AuthenticationController::class, 'register']);
Route::post('login', [AuthenticationController::class, 'login']);
// Route::post('/ik/store', [IzinKeluarController::class, 'store']);

Route::prefix('baak')->group(function () {
    Route::post('/login', [BaakAuthenticationController::class, 'login']);
});
