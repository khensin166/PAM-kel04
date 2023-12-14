<?php

namespace App\Http\Controllers\IzinRuangan;

use App\Http\Controllers\Controller;
use App\Models\Ruangan;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;

class RuanganController extends Controller
{
    public function store(Request $request)
    {
        $rules = [
            'nama_ruangan' => 'required|string',
        ];

        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $ruangan = Ruangan::create([
            'nama_ruangan' => $request->input('nama_ruangan'),
            'status' => true,
        ]);
        return response([
            'message' => 'Ruangan baru berhasil ditambahkan',
            'Ruangan' => $ruangan
        ], 200);
    }

    public function destroy($id)
{
    $ruangan = Ruangan::find($id);

    if (!$ruangan) {
        return response()->json(['message' => 'Ruangan tidak ditemukan'], 404);
    }

    // Jika ruangan sedang digunakan (status = false), ruangan tidak dapat dihapus
    if (!$ruangan->status) {
        return response()->json(['message' => 'Ruangan sedang digunakan dan tidak dapat dihapus'], 400);
    }

    $ruangan->delete();

    return response()->json(['message' => 'Ruangan berhasil dihapus'], 200);
}
}
