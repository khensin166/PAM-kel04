<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class IzinRuangan extends Model
{
    use HasFactory;

    protected $fillable = [
        'mahasiswa_id',
        'ruangan_id',
        'rencana_mulai',
        'rencana_berakhir',
        'keterangan',
        'status'
    ];

    public function mahasiswa(): BelongsTo {
        return $this->belongsTo(Mahasiswa::class);
    }

    public function ruangan(): BelongsTo {
        return $this->belongsTo(Ruangan::class);
    }
}
