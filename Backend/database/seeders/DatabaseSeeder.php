<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Canteen;
use App\Models\Product;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $password = Hash::make('password123');

        // 1. CREATE THE SUPER ADMIN
        User::updateOrCreate(
            ['email' => 'admin@qless.com'],
            ['name' => 'System Administrator', 'password' => $password, 'role' => 'admin', 'canteen_id' => null]
        );

        // 2. CREATE THE CANTEENS
        $c1 = Canteen::create(['name' => 'SLIIT - Main Canteen', 'location' => 'New Kandy Rd, Malabe', 'operating_hours' => '7:00 AM - 6:00 PM', 'is_open' => 1]);
        $c2 = Canteen::create(['name' => 'SLIIT - Cafe', 'location' => 'New Kandy Rd, Malabe', 'operating_hours' => '8:00 AM - 5:00 PM', 'is_open' => 1]);
        $c3 = Canteen::create(['name' => 'IIT - Rooftop Bistro', 'location' => 'Wellawatte, level 4', 'operating_hours' => '9:00 AM - 8:00 PM', 'is_open' => 1]);
        $c4 = Canteen::create(['name' => 'NSBM - Green Food Court', 'location' => 'Homagama, Student Center', 'operating_hours' => '8:00 AM - 6:00 PM', 'is_open' => 1]);
        $c5 = Canteen::create(['name' => 'CINEC - Maritime Mess', 'location' => 'Malabe, Building C', 'operating_hours' => '6:00 AM - 9:00 PM', 'is_open' => 1]);
        $c6 = Canteen::create(['name' => 'KDU - Cadets Canteen', 'location' => 'Ratmalana, Mess Hall', 'operating_hours' => '6:00 AM - 10:00 PM', 'is_open' => 1]);

        // 3. CREATE THE MANAGERS
        User::create(['name' => 'Kamal Perera', 'email' => 'manager.sliit@qless.com', 'password' => $password, 'role' => 'manager', 'canteen_id' => $c1->id]);
        User::create(['name' => 'Mahesh Kumara', 'email' => 'manager.sliitcafe@qless.com', 'password' => $password, 'role' => 'manager', 'canteen_id' => $c2->id]);
        User::create(['name' => 'Sarah Jones', 'email' => 'manager.iit@qless.com', 'password' => $password, 'role' => 'manager', 'canteen_id' => $c3->id]);
        User::create(['name' => 'Chathura Gunawardena', 'email' => 'manager.nsbm@qless.com', 'password' => $password, 'role' => 'manager', 'canteen_id' => $c4->id]);
        User::create(['name' => 'Capt. Perera', 'email' => 'manager.cinec@qless.com', 'password' => $password, 'role' => 'manager', 'canteen_id' => $c5->id]);
        User::create(['name' => 'Major Sunil', 'email' => 'manager.kdu@qless.com', 'password' => $password, 'role' => 'manager', 'canteen_id' => $c6->id]);

        // 4. CREATE THE STUDENTS (Automatically assigned to SLIIT Main Canteen - ID 1)
        $students = [
            ['name' => 'Avishka Fernando', 'email' => 'avishka@sliit.lk'],
            ['name' => 'Kavindi Perera', 'email' => 'kavindi@sliit.lk'],
            ['name' => 'Sanduni Silva', 'email' => 'sanduni@sliit.lk'],
            ['name' => 'Nuwan Pradeep', 'email' => 'nuwan@iit.ac.lk'],
            ['name' => 'Dilshan Madushanka', 'email' => 'dilshanM@sliit.lk']
        ];

        foreach ($students as $student) {
            User::create([
                'name'       => $student['name'],
                'email'      => $student['email'],
                'password'   => $password,
                'role'       => 'student',
                'canteen_id' => $c1->id // Assigned to $c1 directly!
            ]);
        }

// 5. CREATE THE MENU ITEMS
        // SLIIT Main Canteen (Canteen 1)
        Product::create(['canteen_id' => $c1->id, 'item_name' => 'Chicken Fried Rice', 'price' => 650.00, 'category' => 'Mains', 'is_available' => 1, 'description' => 'Basmati rice with fried chicken and chilli paste.', 'image_url' => 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?auto=format&fit=crop&w=500&q=60']);
        Product::create(['canteen_id' => $c1->id, 'item_name' => 'Vegetable Kottu', 'price' => 550.00, 'category' => 'Mains', 'is_available' => 1, 'description' => 'Spicy chopped roti with fresh vegetables and gravy.', 'image_url' => 'https://www.hungrylankan.com/wp-content/uploads/2024/07/IMG_4940.jpeg']);
        Product::create(['canteen_id' => $c1->id, 'item_name' => 'Iced Coffee', 'price' => 110.00, 'category' => 'Drinks', 'is_available' => 1, 'description' => 'Chilled Sri Lankan style sweet iced coffee.', 'image_url' => 'https://images.unsplash.com/photo-1578612599351-434b8ff87a70?q=80&w=750&auto=format&fit=crop']);

        // SLIIT Cafe (Canteen 2)
        Product::create(['canteen_id' => $c2->id, 'item_name' => 'Crispy Chicken Burger', 'price' => 550.00, 'category' => 'Mains', 'is_available' => 1, 'description' => 'Crispy chicken patty with fresh lettuce and mayo.', 'image_url' => 'https://plus.unsplash.com/premium_photo-1695758787947-0aff87c1f93a?w=600&auto=format&fit=crop']);
        Product::create(['canteen_id' => $c2->id, 'item_name' => 'Chocolate Brownie', 'price' => 200.00, 'category' => 'Pastry', 'is_available' => 1, 'description' => 'Rich, fudgy dark chocolate brownie.', 'image_url' => 'https://images.unsplash.com/photo-1606313564573-104197cf8f91?w=600&auto=format&fit=crop']);

        // IIT Rooftop Bistro (Canteen 3)
        Product::create(['canteen_id' => $c3->id, 'item_name' => 'Club Sandwich', 'price' => 400.00, 'category' => 'Mains', 'is_available' => 1, 'description' => 'Triple layer toasted sandwich with chicken and cheese.', 'image_url' => 'https://plus.unsplash.com/premium_photo-1738802845911-809a01acfa50?w=600&auto=format&fit=crop']);
        Product::create(['canteen_id' => $c3->id, 'item_name' => 'French Fries', 'price' => 250.00, 'category' => 'Snacks', 'is_available' => 1, 'description' => 'Crispy golden salted potato fries.', 'image_url' => 'https://images.unsplash.com/photo-1541592106381-b31e9677c0e5?w=600&auto=format&fit=crop']);    }
}