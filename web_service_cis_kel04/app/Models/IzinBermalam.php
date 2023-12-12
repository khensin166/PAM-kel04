<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class IzinBermalam extends Model
{
    use HasFactory;

    protected $fillable = [
        'mahasiswa_id',
        'rencana_berangkat',
        'rencana_kembali',
        'keterangan',
        
    ];

    public function Mahasiswa(): BelongsTo{
        return $this->belongsTo(Mahasiswa::class);
    }
}
