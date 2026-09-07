import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  double _age = 25;
  String _country = 'United States';
  List<String> _countries = [];

  final List<String> selectedHabits = [];
  final List<String> availableHabits = [
    'Wake Up Early',
    'Workout',
    'Drink Water',
    'Meditate',
    'Read a Book',
    'Practice Gratitude',
    'Sleep 8 Hours',
    'Eat Healthy',
    'Journal',
    'Walk 10,000 Steps',
  ];

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _fetchCountries() async {
    const subsetCountries = [
      'United States',
      'Canada',
      'United Kingdom',
      'Australia',
      'India',
      'Germany',
      'France',
      'Japan',
      'China',
      'Brazil',
      'South Africa',
    ];

    final countries = [...subsetCountries]..sort();
    if (!mounted) return;

    setState(() {
      _countries = countries;
      _country = _countries.isNotEmpty ? _countries.first : 'United States';
    });
  }

  // ADDED FOR TASK 2: validate required fields and email format.
  bool _validateForm() {
    final email = _emailController.text.trim();
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (_nameController.text.trim().isEmpty ||
        _usernameController.text.trim().isEmpty ||
        email.isEmpty ||
        _passwordController.text.isEmpty) {
      _showMessage('Please fill in all required fields.');
      return false;
    }

    if (!emailRegex.hasMatch(email)) {
      _showMessage('Please enter a valid email address.');
      return false;
    }

    if (_passwordController.text.length < 6) {
      _showMessage('Password must contain at least 6 characters.');
      return false;
    }

    return true;
  }

  // ADDED FOR TASK 2/3: persist registration data locally.
  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('user_name', _nameController.text.trim());
    await prefs.setString('user_username', _usernameController.text.trim());
    await prefs.setString('user_email', _emailController.text.trim().toLowerCase());
    await prefs.setString('user_password', _passwordController.text);
    await prefs.setDouble('user_age', _age);
    await prefs.setString('user_country', _country);
    await prefs.setStringList('user_habits', selectedHabits);
    await prefs.setBool('user_registered', true);
  }

  // ADDED FOR TASK 2/3: combine validation, storage and navigation.
  Future<void> _register() async {
    if (!_validateForm()) return;

    try {
      await _saveUserData();
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful. Please log in.')),
      );
      Navigator.pushReplacementNamed(context, '/login');
    } catch (error) {
      _showMessage('Could not save your account. Please try again.');
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
      appBar: AppBar(
        backgroundColor: AppStyles.primaryBlue,
        title: const Text('Register', style: AppStyles.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppStyles.authGradient),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    width: 70,
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInputField(_nameController, 'Name', Icons.person),
                const SizedBox(height: 10),
                _buildInputField(_usernameController, 'Username', Icons.alternate_email),
                const SizedBox(height: 10),
                _buildInputField(_emailController, 'Email', Icons.email,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 10),
                _buildInputField(_passwordController, 'Password', Icons.lock,
                    obscureText: true),
                const SizedBox(height: 10),
                const Text('Age', style: AppStyles.label),
                Text(
                  '${_age.round()} years',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Slider(
                  value: _age,
                  min: 21,
                  max: 100,
                  divisions: 79,
                  activeColor: Colors.white,
                  inactiveColor: Colors.white54,
                  onChanged: (value) => setState(() => _age = value),
                ),
                const SizedBox(height: 10),
                _buildCountryDropdown(),
                const SizedBox(height: 15),
                const Text('Select Your Habits', style: AppStyles.label),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: availableHabits.map((habit) {
                    final isSelected = selectedHabits.contains(habit);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedHabits.remove(habit);
                          } else {
                            selectedHabits.add(habit);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppStyles.primaryBlue : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Text(
                          habit,
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppStyles.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 25),
                Center(
                  child: ElevatedButton(
                    onPressed: _register,
                    style: AppStyles.primaryButton,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(color: Colors.white),
                    ),
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

  Widget _buildCountryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: AppStyles.inputBox,
      child: DropdownButton<String>(
        value: _countries.contains(_country) ? _country : null,
        hint: const Text('Select country'),
        icon: const Icon(Icons.arrow_drop_down, color: AppStyles.primaryBlue),
        isExpanded: true,
        underline: const SizedBox(),
        items: _countries.map((value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: (newValue) {
          if (newValue == null) return;
          setState(() => _country = newValue);
        },
      ),
    );
  }
}
