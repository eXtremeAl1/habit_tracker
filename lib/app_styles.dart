import 'package:flutter/material.dart';

/// Shared styling used by the Login and Register screens.
class AppStyles {
  static const Color primaryBlue = Color(0xFF1976D2);
  static const Color darkBlue = Color(0xFF0D47A1);

  static const LinearGradient authGradient = LinearGradient(
    colors: [primaryBlue, darkBlue],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const TextStyle title = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle label = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static InputDecoration inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: primaryBlue),
      hintText: hint,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    );
  }

  static BoxDecoration inputBox = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
  );

  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: primaryBlue,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
  );
}
