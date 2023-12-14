<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Ruangan extends Model
{
    use HasFactory;

    protected $fillable = [
        'nama_ruangan',
        'status',
    ];

    public function ruangan(): HasMany
    {
        return $this->hasMany(Ruangan::class);
    }

    public function mahasiswa(): BelongsTo {
        return $this->belongsTo(Mahasiswa::class);
    }
}
