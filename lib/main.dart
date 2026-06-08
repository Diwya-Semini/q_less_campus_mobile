import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:q_less_campus/providers/auth_provider.dart';
import 'package:q_less_campus/providers/cart_provider.dart';
import 'package:q_less_campus/providers/order_provider.dart';
import 'package:q_less_campus/screens/login_screen.dart';
import 'package:q_less_campus/screens/spalsh_screen.dart';
import 'providers/menu_provider.dart';
import 'screens/main_layout_screen.dart';

void main() {
  runApp(const QLessApp());
}

class QLessApp extends StatelessWidget {
  const QLessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Q-Less Campus',
        debugShowCheckedModeBanner: false,

        themeMode: ThemeMode.system,

        // 1. LIGHT THEME
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          primaryColor: const Color(0xFFA5672C),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFDA750),
            brightness: Brightness.light,
            primary: const Color(0xFFA5672C),
            surface: const Color(0xFFFAFAFA),
          ),
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
          cardTheme: const CardThemeData(color: Colors.white, elevation: 3),
        ),

        // 2. DARK THEME
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          primaryColor: const Color(0xFFFDA750),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFDA750),
            brightness: Brightness.dark,
            primary: const Color(0xFFFDA750),
            surface: const Color(0xFF1E1E1E),
          ),
          scaffoldBackgroundColor: const Color(0xFF121212),
          cardTheme: const CardThemeData(
            color: Color(0xFF1E1E1E),
            elevation: 1,
          ),
        ),

        home: const SplashScreen(),
      ),
    );
  }
}
