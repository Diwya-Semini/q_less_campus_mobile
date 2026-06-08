<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register - Q-Less Marketplace</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="bg-[#0f0f12] text-gray-100 font-sans min-h-screen flex items-center justify-center p-4 antialiased">
    
    <div class="w-full">
        {{ $slot }}
    </div>

</body>
</html>