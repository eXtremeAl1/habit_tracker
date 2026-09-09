import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart'; // Dodan nedostajući import

void main() {
  runApp(HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habitt',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const RegisterScreen(),
      },
    );
  }
}