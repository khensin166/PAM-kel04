<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class IzinKeluar extends Model
{
    use HasFactory;

    protected $fillable = [
        'mahasiswa_id',
        'berangkat',
        'kembali',
        'keterangan',
        'status',
    ];

    public function mahasiswa(): BelongsTo {
        return $this->belongsTo(Mahasiswa::class);
    }
}
