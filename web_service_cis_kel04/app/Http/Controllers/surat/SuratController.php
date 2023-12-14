<?php

namespace App\Http\Controllers\surat;

use App\Http\Controllers\Controller;
use App\Models\Surat;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class SuratController extends Controller
{
    public function store(Request $request)
    {
        $rules = [
            'kategori_surat' => 'required|string',
            'keterangan' => 'required|string|min:6',
        ];

        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $surat = Surat::create([
            'kategori_surat' => $request->input('kategori_surat'),
            'keterangan' => $request->input('keterangan'),
            'status' => 'pending',
            'mahasiswa_id' => Auth::guard('mahasiswa')->user()->id
        ]);
        return response([
            'message' => 'Request surat berhasil dibuat',
            'RequestSurat' => $surat
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

        $surat = Surat::find($id);

        if (!$surat) {
            return response()->json(['message' => 'Surat not found'], 404);
        }

        $surat->update([
            'status' => $request->input('status'),
        ]);

        return response([
            'message' => 'Status surat berhasil diperbarui',
            'RequestIzinSurat' => $surat
        ], 200);
    }
}
