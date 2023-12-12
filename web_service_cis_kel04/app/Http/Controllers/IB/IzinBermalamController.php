<?php

namespace App\Http\Controllers\IB;

use App\Http\Controllers\Controller;
use App\Http\Requests\IzinBermalamRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class IzinBermalamController extends Controller
{
    public function store(IzinBermalamRequest $request){
        // $request->validated();

        // Auth::guard('mahasiswa')->user()->ib()->create([
        //     'keterangan' => $request->keterangan,
        //     'rencana_berangkat' => $request->rencana_berangkat,
        //     'rencana_kembali' => $request->rencana_kembali,
        //     'tujuan' => $request->tujuan,
        // ]);

        return response([
            'message' => 'success'
        ], 201);
    }
}
