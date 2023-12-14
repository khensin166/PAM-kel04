<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Notifications\Notifiable;

class Mahasiswa extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $guard = 'mahasiswa';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'ktp',
        'nim',
        'nama',
        'handphone',
        'email',
        'password',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    public function ik(): HasMany
    {
        return $this->hasMany(IzinKeluar::class);
    }

    public function ib(): HasMany
    {
        return $this->hasMany(IzinBermalam::class);
    }

    public function IzinRuangan(): HasMany
    {
        return $this->hasMany(IzinRuangan::class);
    }

    public function surat(): HasMany
    {
        return $this->hasMany(Surat::class);
    }
}
