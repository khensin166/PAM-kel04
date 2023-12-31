<?php

namespace App\Http\Controllers\ik;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\IzinKeluar;
use Illuminate\Http\Request;


class IzinKeluarController extends Controller
{

    public function index()
    {

        $data_ik = IzinKeluar::with('mahasiswa')->where('status', 'pending')->latest()->get();
        return response([
            'data_ik' => $data_ik
        ], 200);
    }

    public function dataIKMhs()
    {
        $mahasiswa = Auth::guard('mahasiswa')->id();
        $data_ik = IzinKeluar::with('mahasiswa')->latest()->where('mahasiswa_id', $mahasiswa)->get();
        return response([
            'data_ik' => $data_ik
        ], 200);
    }

    public function store(Request $request)
    {
        $rules = [
            'berangkat' => 'required|date',
            'kembali' => 'required|date|after:berangkat',
            'keterangan' => 'required|string|min:6',
        ];

        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $user = IzinKeluar::create([
            'keterangan' => $request->input('keterangan'),
            'berangkat' => $request->input('berangkat'),
            'kembali' => $request->input('kembali'),
            'status' => 'pending',
            'mahasiswa_id' => Auth::guard('mahasiswa')->user()->id
        ]);
        return response([
            'message' => 'Request izin keluar berhasil dibuat',
            'RequestIzinKeluar' => $user
        ], 200);
    }

    public function statusUpdate(Request $request, $id)
    {
        $rules = [
            'status' => 'required|string|in:approved,rejected,cancel',
        ];

        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $izinKeluar = IzinKeluar::find($id);

        if (!$izinKeluar) {
            return response()->json(['message' => 'Izin Keluar not found'], 404);
        }

        $izinKeluar->update([
            'status' => $request->input('status'),
        ]);

        return response([
            'message' => 'Status Izin Keluar berhasil diperbarui',
            'RequestIzinKeluar' => $izinKeluar
        ], 200);
    }
}
