<?php

namespace App\Http\Controllers\Mahasiswa;

use App\Http\Controllers\Controller;
use App\Http\Requests\mLoginRequest;
use App\Http\Requests\mRegisterRequest;
use App\Models\Mahasiswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthenticationController extends Controller
{
    public function register(mRegisterRequest $request)
    {
        $request->validated();

        $mhsData = [
            'ktp' => $request->ktp,
            'nim' => $request->nim,
            'nama' => $request->nama,
            'handphone' => $request->handphone,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ];

        $mahasiswa = Mahasiswa::create($mhsData);
        $token = $mahasiswa->createToken('cis')->plainTextToken;

        return response([
            'mahasiswa' => $mahasiswa,
            'token' => $token
        ], 201);
    }

    public function login(mLoginRequest $request)
    {
        $request->validated();

        $user = Mahasiswa::whereUsername($request->username)->first();
        // dd($user);
        if (!$user || !Hash::check($request->password, $user->password)) {
            return response([
                'message' => 'invalid credentials'
            ], 422);
        }

        $token = $user->createToken('forumapp')->plainTextToken;

        return response([
            'user' => $user,
            'token' => $token,
        ], 200);
    }
}
