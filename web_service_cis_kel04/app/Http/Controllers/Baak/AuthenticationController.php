<?php

namespace App\Http\Controllers\Baak;

use App\Http\Controllers\Controller;
use App\Http\Requests\bLoginRequest;
use App\Models\Baak;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthenticationController extends Controller
{
    public function login(bLoginRequest $request)
    {
        $request->validated();

        $baak = Baak::whereEmail($request->email)->first();
        
        if (!$baak || !Hash::check($request->password, $baak->password)) {
            return response([
                'message' => 'invalid credentials'
            ], 422);
        }

        $token = $baak->createToken('cis')->plainTextToken;

        return response([
            'baak' => $baak,
            'token' => $token,
        ], 200);
    }
}
