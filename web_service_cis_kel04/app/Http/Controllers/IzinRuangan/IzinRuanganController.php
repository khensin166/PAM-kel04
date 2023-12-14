<?php

namespace App\Http\Controllers\IzinRuangan;

use App\Http\Controllers\Controller;
use App\Models\IzinRuangan;
use App\Models\Ruangan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;

class IzinRuanganController extends Controller
{
    public function store(Request $request)
    {
        $mahasiswaId = Auth::guard('mahasiswa')->id();

        $rules = [
            'ruangan_id' => 'required|exists:ruangans,id',
            'rencana_mulai' => 'required|date',
            'rencana_berakhir' => 'required|date|after:rencana_mulai',
            'keterangan' => 'required|string|min:6',
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        // Periksa status ruangan
        $ruangan = Ruangan::find($request->ruangan_id);

        if (!$ruangan) {
            return response()->json(['message' => 'Ruangan tidak ditemukan'], 404);
        }

        if ($ruangan->status == false) {
            return response()->json(['message' => 'Ruangan sedang tidak tersedia untuk peminjaman'], 400);
        }

        // Lanjutkan proses peminjaman ruangan jika status ruangan true
        $izinRuangan = IzinRuangan::create([
            'mahasiswa_id' => $mahasiswaId,
            'ruangan_id' => $request->ruangan_id,
            'rencana_mulai' => $request->rencana_mulai,
            'rencana_berakhir' => $request->rencana_berakhir,
            'keterangan' => $request->keterangan,
            'status' => 'pending'
        ]);

        // Set status ruangan menjadi false karena sedang dipinjam
        $ruangan->update(['status' => false]);

        return response([
            'message' => 'Booking ruangan berhasil',
            'IzinRuangan' => $izinRuangan,
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

        $izinRuangan = IzinRuangan::find($id);

        if (!$izinRuangan) {
            return response()->json(['message' => 'Izin ruangan not found'], 404);
        }

        $izinRuangan->update([
            'status' => $request->input('status'),
        ]);

        return response([
            'message' => 'Status Izin Ruangan berhasil diperbarui',
            'RequestIzinRuangan' => $izinRuangan
        ], 200);
    }
}
