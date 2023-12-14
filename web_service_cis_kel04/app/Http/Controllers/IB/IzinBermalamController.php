<?php

namespace App\Http\Controllers\IB;

use App\Http\Controllers\Controller;
use App\Models\IzinBermalam;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;

class IzinBermalamController extends Controller
{
    public function index()
    {

        $data_ib = IzinBermalam::with('mahasiswa')->where('status', 'pending')->latest()->get();
        return response([
            'data_ib' => $data_ib
        ], 200);
    }

    public function dataIKMhs()
    {
        $mahasiswa = Auth::guard('mahasiswa')->id();
        $data_ib = IzinBermalam::with('mahasiswa')->latest()->where('mahasiswa_id', $mahasiswa)->get();
        return response([
            'data_ib' => $data_ib
        ], 200);
    }

    public function store(Request $request)
    {
        $rules = [
            'rencana_berangkat' => 'required|date',
            'rencana_kembali' => 'required|date|after:berangkat',
            'keterangan' => 'required|string|min:6',
            'tujuan' => 'required',
        ];

        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        // Cek apakah izin bermalam hanya bisa diminta pada hari Jumat di atas jam 17.00
        $rencanaBerangkat = Carbon::parse($request->input('rencana_berangkat'));
        if ($rencanaBerangkat->dayOfWeek !== Carbon::FRIDAY || $rencanaBerangkat->hour < 17) {
            return response()->json(['message' => 'Izin bermalam hanya dapat diminta pada hari Jumat di atas jam 17.00'], 400);
        }

        // Cek apakah izin bermalam hanya bisa diminta pada hari Sabtu antara jam 08.00 - 17.00
        if ($rencanaBerangkat->dayOfWeek === Carbon::SATURDAY && ($rencanaBerangkat->hour < 8 || $rencanaBerangkat->hour >= 17)) {
            return response()->json(['message' => 'Izin bermalam hanya dapat diminta pada hari Sabtu antara jam 08.00 - 17.00'], 400);
        }

        // Cek apakah izin bermalam di luar waktu yang diizinkan, maka otomatis batalkan
        if ($rencanaBerangkat->isPast()) {
            return response()->json(['message' => 'Izin bermalam tidak dapat diminta untuk waktu yang sudah lewat'], 400);
        }

        $mahasiswa = IzinBermalam::create([
            'keterangan' => $request->input('keterangan'),
            'rencana_berangkat' => $request->input('rencana_berangkat'),
            'rencana_kembali' => $request->input('rencana_kembali'),
            'tujuan' => $request->input('tujuan'),
            'status' => 'pending',
            'mahasiswa_id' => Auth::guard('mahasiswa')->user()->id
        ]);

        return response([
            'message' => 'Request izin bermalam berhasil dibuat',
            'RequestIzinBermalam' => $mahasiswa
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

        $izinBermalam = IzinBermalam::find($id);

        if (!$izinBermalam) {
            return response()->json(['message' => 'Izin Bermalam not found'], 404);
        }

        $izinBermalam->update([
            'status' => $request->input('status'),
        ]);

        return response([
            'message' => 'Status Izin Bermalam berhasil diperbarui',
            'RequestIzinBermalam' => $izinBermalam
        ], 200);
    }
}
