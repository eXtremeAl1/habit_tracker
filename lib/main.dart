import 'package:flutter/material.dart';
import 'login_screen.dart';


void main() {
  runApp(HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      title: 'Habitt',
      // ADDED FOR TASK 1: named navigation routes.
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const RegisterScreen(),
      },
    );
  }
}
