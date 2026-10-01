import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'country_list.dart';
import 'habit_tracker_screen.dart';
import 'login_screen.dart';

final Map<String, Color> _habitColors = {
    'Amber': Colors.amber,
    'Red Accent': Colors.redAccent,
    'Light Blue': Colors.lightBlue,
    'Light Green': Colors.lightGreen,
    'Purple Accent': Colors.purpleAccent,
    'Orange': Colors.orange,
    'Teal': Colors.teal,
    'Deep Purple': Colors.deepPurple,
  };

 Future<void> _loadCountries() async {
    try {
      List<String> countries = await fetchCountries();
      setState(() {
        _countries = countries;
      });
    } catch (e) {
      // Handle error
      _showToast('Error fetching countries');
    }
  }
SharedPreferences prefs = await SharedPreferences.getInstance();

// Assign random colors to selected habits.
Map<String, String> selectedHabitsMap = {};
final random = Random();
final colorKeys = _habitColors.keys.toList();
for (var habit in selectedHabits) {
  var randomColor =
      _habitColors[colorKeys[random.nextInt(colorKeys.length)]]!;
  selectedHabitsMap[habit] = randomColor.value.toRadixString(16);
}

// Save user information and habits to shared preferences.
await prefs.setString('name', name);
await prefs.setString('username', username);
await prefs.setDouble('age', _age);
await prefs.setString('country', _country);
await prefs.setString('selectedHabitsMap', jsonEncode(selectedHabitsMap));

 void _toggleHabitSelection(String habit) {
    setState(() {
      if (selectedHabits.contains(habit)) {
        selectedHabits.remove(habit);
      } else {
        selectedHabits.add(habit);
      }
    });
  }

return GestureDetector(
  onTap: () => _toggleHabitSelection(habit),
  child: Container(
    padding:
        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      color:
          isSelected ? Colors.blue.shade600 : Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.blue.shade700),
    ),
    child: Text(
      habit,
      style: TextStyle(
        color: isSelected
            ? Colors.white
            : Colors.blue.shade700,
      ),
    ),
  ),
);
