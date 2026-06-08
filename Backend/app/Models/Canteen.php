<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Canteen extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'location',
        'operating_hours',
        'is_open'
    ];

    public function orders()
    {
        return $this->hasMany(Order::class);
    }
}