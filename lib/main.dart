import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:q_less_campus/screens/login_screen.dart';
import 'providers/menu_provider.dart';
import 'package:q_less_campus/navigation_hub.dart';

// IMPORTANT: Make sure this import points to your actual starting screen!
// If your first screen is something else, change 'navigation_hub.dart' to match it.

void main() {
  runApp(
    // 1. The MultiProvider wraps the ENTIRE app for State Management
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MenuProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Q-Less Campus',

      // --- THEME SETTINGS RESTORED --- //

      // 1. Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFDA750), // Your brand orange
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: true,
      ),

      // 2. Dark Theme (This brings your sleek dark mode back!)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFDA750), // Your brand orange
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(
          0xFF121212,
        ), // Standard dark background
        useMaterial3: true,
      ),

      // 3. This tells Flutter to automatically switch based on the phone's settings!
      themeMode: ThemeMode.system,

      // ------------------------------- //
      home:
          const LoginScreen(), // Make sure this matches your actual starting widget
    );
  }
}
