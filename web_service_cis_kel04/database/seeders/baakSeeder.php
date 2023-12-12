<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class baakSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('baaks')->truncate();

        // Buat data seeder
        DB::table('baaks')->insert([
            'id' => 1,
            'nama' => 'Baak1',
            'email' => 'baak1@gmail.com',
            'email_verified_at' => now(),
            'password' => Hash::make('password123'),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        DB::table('baaks')->insert([
            'id' => 2,
            'nama' => 'Nama Baak 2',
            'email' => 'baak2@example.com',
            'email_verified_at' => now(),
            'password' => Hash::make('password456'),
            'created_at' => now(),
            'updated_at' => now(),
        ]);

    }
}
