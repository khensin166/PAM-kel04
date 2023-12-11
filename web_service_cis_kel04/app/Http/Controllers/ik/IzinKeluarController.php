<?php

namespace App\Http\Controllers\ik;

use App\Http\Controllers\Controller;
use App\Http\Requests\IKRequest;
use App\Models\IzinKeluar;
use App\Models\Mahasiswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class IzinKeluarController extends Controller
{

    public function index()
    {
        $mahasiswa = Auth::guard('mahasiswa')->id();
        $data_ik = IzinKeluar::with('mahasiswa')->latest()->get()->where('mahasiswa_id', $mahasiswa);
        return response([
            'data_ik' => $data_ik
        ], 200);
    }

    public function store(IKRequest $request)
    {
        $request->validated();

        $mahasiswa = Auth::guard('mahasiswa')->user();

        if ($mahasiswa) {

            $mahasiswa->ik()->create([
                'mahasiswa_id' => $mahasiswa->id,
                'berangkat' => $request->berangkat,
                'kembali' => $request->kembali,
                'keterangan' => $request->keterangan,
                'status' => $request->status,
            ]);

            return response([
                'message' => 'success',
            ], 201);
        } else {
            return response(['message' => 'Unauthorized'], 401);
        }
    }

    public function statusUpdate(){
        
    }
}
