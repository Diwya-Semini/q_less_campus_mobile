@extends('layouts.manager')

@section('content')
<div class="max-w-7xl mx-auto pb-12">
    
    <!-- Top Action Header Status bar -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <div>
            <h1 class="text-3xl font-black text-white tracking-tight">Kitchen Dashboard</h1>
            <p class="text-gray-400 mt-1">Today's real-time performance metrics.</p>
        </div>
        <div class="bg-white/5 border border-white/10 px-4 py-2 rounded-xl text-sm font-bold text-white flex items-center shadow-inner">
            <span class="w-2 h-2 rounded-full bg-green-500 mr-2 animate-pulse"></span>
            Kitchen is Open
        </div>
    </div>

    <!-- Analytics Cards Grid Row Matrix -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        
        <!-- CARD 1: TOTAL ORDERS TODAY -->
        <div class="bg-white/[0.02] border border-white/5 rounded-2xl p-6 backdrop-blur-xl shadow-lg relative overflow-hidden">
            <p class="text-gray-400 text-sm font-bold tracking-wider uppercase mb-1">Total Orders Today</p>
            <h3 class="text-3xl font-black text-white">{{ $totalOrdersToday }}</h3>
            <p class="text-green-400 text-xs font-bold mt-2 flex items-center">
                <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 10l7-7m0 0l7 7m-7-7v18"></path>
                </svg> Real-time
            </p>
        </div>

        <!-- CARD 2: TOTAL REVENUE TODAY -->
        <div class="bg-white/[0.02] border border-white/5 rounded-2xl p-6 backdrop-blur-xl shadow-lg relative overflow-hidden">
            <p class="text-gray-400 text-sm font-bold tracking-wider uppercase mb-1">Total Revenue</p>
            <h3 class="text-3xl font-black text-white">Rs. {{ number_format($totalRevenueToday, 2) }}</h3>
            <p class="text-green-400 text-xs font-bold mt-2 flex items-center">
                <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 10l7-7m0 0l7 7m-7-7v18"></path>
                </svg> Today's Earnings
            </p>
        </div>

        <!-- CARD 3: AVERAGE PREPARATION METRIC -->
        <div class="bg-white/[0.02] border border-white/5 rounded-2xl p-6 backdrop-blur-xl shadow-lg relative overflow-hidden">
            <p class="text-gray-400 text-sm font-bold tracking-wider uppercase mb-1">Avg Prep Time</p>
            <h3 class="text-3xl font-black text-white">--</h3>
            <p class="text-orange-400 text-xs font-bold mt-2 flex items-center">
                Requires time tracking
            </p>
        </div>

        <!-- live stock availability -->
        <div class="bg-white/[0.02] border border-white/5 rounded-2xl p-6 backdrop-blur-xl shadow-lg relative overflow-hidden">
            <p class="text-gray-400 text-sm font-bold tracking-wider uppercase mb-1">Active Menu Items</p>
            <h3 class="text-3xl font-black text-white">{{ $activeMenuItems }} <span class="text-gray-500 text-lg font-medium">/ {{ $totalProducts }}</span></h3>
            <p class="{{ $outOfStockItems > 0 ? 'text-red-400' : 'text-green-400' }} text-xs font-bold mt-2 flex items-center">
                {{ $outOfStockItems }} items currently out of stock
            </p>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        
        <!-- revenve analiytic chart -->
        <div class="lg:col-span-2 bg-white/[0.02] border border-white/5 rounded-2xl p-6 backdrop-blur-xl shadow-lg h-96 flex flex-col justify-between">
            <div class="flex justify-between items-center mb-2">
                <h3 class="text-sm font-bold text-gray-400 uppercase tracking-wider">Weekly Revenue Stream</h3>
                <span class="text-xs font-semibold text-orange-400">LKR Analytics</span>
            </div>
            
            <!-- Real-Time Graphic Canvas Space wrapper -->
            <div class="relative w-full h-72">
                <canvas id="revenueChart"></canvas>
            </div>
        </div>
        
        <!-- QUICK ACTIONS CONTROL BOX -->
        <div class="bg-white/[0.02] border border-white/5 rounded-2xl p-6 backdrop-blur-xl shadow-lg">
            <h3 class="text-lg font-black text-white mb-4 border-b border-white/10 pb-2">Quick Actions</h3>
            <div class="space-y-3">
                <a href="{{ route('manager.menu') }}" class="w-full bg-white/5 hover:bg-white/10 border border-white/10 text-white font-bold py-3 px-4 rounded-xl transition duration-200 flex items-center justify-between">
                    <span>Update Menu Availability</span>
                    <svg class="w-4 h-4 text-orange-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
                </a>
                <a href="{{ route('manager.orders') }}" class="w-full bg-white/5 hover:bg-white/10 border border-white/10 text-white font-bold py-3 px-4 rounded-xl transition duration-200 flex items-center justify-between">
                    <span>Jump to Live Orders</span>
                    <svg class="w-4 h-4 text-orange-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
                </a>
            </div>
        </div>
    </div>
</div>

<!-- INJECT INTERACTIVE GRAPHIC SCRIPT LOGIC -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const ctx = document.getElementById('revenueChart').getContext('2d');
        
        // Setup premium gradient path fill for area shading under the path lines
        const gradient = ctx.createLinearGradient(0, 0, 0, 250);
        gradient.addColorStop(0, 'rgba(249, 115, 22, 0.22)'); // Smooth orange glow tracking matching QLess accent theme
        gradient.addColorStop(1, 'rgba(249, 115, 22, 0.00)');

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: {!! json_encode($chartLabels) !!},
                datasets: [{
                    label: 'Daily Sales Revenue',
                    data: {!! json_encode($chartValues) !!},
                    borderColor: '#f97316', // Bold tailwind orange accent line
                    borderWidth: 3,
                    pointBackgroundColor: '#f97316',
                    pointBorderColor: 'rgba(255,255,255,0.1)',
                    pointHoverRadius: 7,
                    fill: true,
                    backgroundColor: gradient,
                    tension: 0.35 // Sleek wave arcs instead of rigid blocky corners
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false } // Cleans layout cluster
                },
                scales: {
                    x: {
                        grid: { display: false },
                        ticks: { color: '#9ca3af', font: { weight: '600', size: 11 } }
                    },
                    y: {
                        grid: { color: 'rgba(255, 255, 255, 0.04)' },
                        ticks: { color: '#6b7280', font: { family: 'monospace' } }
                    }
                }
            }
        });
    });
</script>
@endsection