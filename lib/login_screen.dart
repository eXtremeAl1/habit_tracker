import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ADDED FOR TASK 4: validate required fields and email format.
  bool _validateForm() {
    final email = _emailController.text.trim();
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (email.isEmpty || _passwordController.text.isEmpty) {
      _showMessage('Please enter your email and password.');
      return false;
    }

    if (!emailRegex.hasMatch(email)) {
      _showMessage('Please enter a valid email address.');
      return false;
    }

    return true;
  }

  // ADDED FOR TASK 4: compare entered credentials with SharedPreferences.
  Future<void> _authenticateUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedEmail = prefs.getString('user_email');
      final storedPassword = prefs.getString('user_password');

      final email = _emailController.text.trim().toLowerCase();
      final password = _passwordController.text;

      if (storedEmail == null || storedPassword == null) {
        _showMessage('No registered account found. Please sign up first.');
        return;
      }

      if (email == storedEmail && password == storedPassword) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
      } else {
        _showMessage('Incorrect email or password.');
      }
    } catch (error) {
      _showMessage('Could not access stored account data.');
    }
  }

  // ADDED FOR TASK 4: combine validation and authentication.
  void _login() {
    if (_validateForm()) {
      _authenticateUser();
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppStyles.authGradient),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/app_logo.png',
                  width: 86,
                  height: 86,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),
                const Text('Habitt', style: AppStyles.title),
                const SizedBox(height: 30),
                _buildInputField(
                  _emailController,
                  'Enter Email',
                  Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  _passwordController,
                  'Enter Password',
                  Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _login,
                  style: AppStyles.primaryButton,
                  child: const Text(
                    'Log in',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: AppStyles.inputBox,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        decoration: AppStyles.inputDecoration(hint: hint, icon: icon),
      ),
    );
  }
}
