import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // This variable automatically picks Navy in Light and White in Dark mode
    final Color adaptiveColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.food_bank_outlined, size: 100, color: adaptiveColor),
            const SizedBox(height: 20),
            Text(
              "Q-LESS",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: adaptiveColor,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 30),
            CircularProgressIndicator(color: adaptiveColor),
          ],
        ),
      ),
    );
  }
}
