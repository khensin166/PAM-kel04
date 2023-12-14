<?php

use App\Http\Controllers\Baak\AuthenticationController as BaakAuthenticationController;
use App\Http\Controllers\IB\IzinBermalamController;
use App\Http\Controllers\ik\IzinKeluarController;
use App\Http\Controllers\IzinRuangan\IzinRuanganController;
use App\Http\Controllers\IzinRuangan\RuanganController;
use App\Http\Controllers\Mahasiswa\AuthenticationController;
use App\Http\Controllers\surat\SuratController;
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


Route::get('/test', function () {
    return  response([
        'message' => 'Hello World!'
    ], 200);
});

// Route::post('/ik/store', [IzinKeluarController::class, 'store']);

Route::prefix('baak')->group(function () {
    //auth baak
    Route::post('/login', [BaakAuthenticationController::class, 'login']);
    
    // ik baak
    Route::get('/ik', [IzinKeluarController::class, 'index'])->middleware(['auth:sanctum', 'abilities:mahasiswa']);
    Route::put('/ik/{id}/status-update', [IzinKeluarController::class, 'statusUpdate']);

    // crud ruangan baak
    Route::post('/ruangan', [RuanganController::class, 'store'])->middleware(['auth:sanctum', 'abilities:mahasiswa']);
    Route::delete('/ruangan/{id}/destroy', [RuanganController::class, 'destroy'])->middleware(['auth:sanctum', 'abilities:mahasiswa']);

    // izin ruangan

});

Route::prefix('mahasiswa')->group(function (){
    
    //data mahasiswa
    
    //auth mahasiswa
    Route::post('register', [AuthenticationController::class, 'register']);
    Route::post('login', [AuthenticationController::class, 'login']);
    Route::get('/dashboard', [IzinKeluarController::class, 'dashboard'])->middleware(['auth:sanctum', 'abilities:mahasiswa']);
    
    // Request ik mahasiswa
    Route::get('/dataIKMhs', [IzinKeluarController::class, 'dataIKMhs'])->middleware(['auth:sanctum', 'abilities:mahasiswa']);
    Route::post('/ik/store', [IzinKeluarController::class, 'store'])->middleware(['auth:sanctum', 'abilities:mahasiswa']);
    
    //request ib mahasiswa
    Route::get('/dataIBMhs', [IzinBermalamController::class, 'dataIBMhs'])->middleware(['auth:sanctum', 'abilities:mahasiswa']);
    Route::post('/ib/store', [IzinBermalamController::class, 'store'])->middleware(['auth:sanctum', 'abilities:mahasiswa']);
    
    //request ruangan
    Route::post('/izinRuangan/store', [IzinRuanganController::class, 'store'])->middleware(['auth:sanctum', 'abilities:mahasiswa']);
    
    //request surat
    Route::post('/surat/store', [SuratController::class, 'store'])->middleware(['auth:sanctum', 'abilities:mahasiswa']);

});


Route::put('/ib/{id}/status-update', [IzinKeluarController::class, 'statusUpdate']);
Route::put('/izinRuangan/{id}/status-update', [IzinRuanganController::class, 'statusUpdate']);
Route::put('/surat/{id}/status-update', [SuratController::class, 'statusUpdate']);
