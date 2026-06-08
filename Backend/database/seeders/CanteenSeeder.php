<?php
namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Canteen; 

class CanteenSeeder extends Seeder
{
    public function run(): void
    {
        Canteen::create([
            'name' => 'APIIT-Main Canteen',
            'location' => 'Union Place, Colombo 02',
            'operating_hours' => '8:00 AM - 4:00 PM',
            'is_open' => true,
        ]);

        Canteen::create([
            'name' => 'SLIIT-Main Canteen',
            'location' => 'SLIIT-Malabe',
            'operating_hours' => '8:00 AM - 4:00 PM',
            'is_open' => true,
        ]);

        Canteen::create([
            'name' => 'SLIIT-Study-Area Cafe',
            'location' => 'Study Area-Building 13',
            'operating_hours' => '8:30 AM - 4:00 PM',
            'is_open' => true, 
        ]);

        Canteen::create([
            'name' => 'IIT-cafe',
            'location' => 'IIT-Malabe',
            'operating_hours' => '8:00 AM - 5:00 PM',
            'is_open' => true,
        ]);

        Canteen::create([
            'name' => 'Colombo-Campus Canteen',
            'location' => 'Colombo-Campus',
            'operating_hours' => '8:30 AM - 5:00 PM',
            'is_open' => true,
        ]);
    }
}