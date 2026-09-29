import 'package:flutter/material.dart';

/// Detail screen for a selected habit.
/// The selected habit is passed in through the constructor so the screen can
/// display item-specific information and navigate back to the list.
class HabitDetailScreen extends StatelessWidget {
  final String habitName;
  final Color habitColor;
  final bool isCompleted;

  const HabitDetailScreen({
    super.key,
    required this.habitName,
    required this.habitColor,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: const Text(
          'Habit Details',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visual identifier for the selected item.
            Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                color: habitColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  habitName.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Item-specific information.
            const Text(
              'Habit name',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            Text(
              habitName,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Status',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  isCompleted ? Icons.check_circle : Icons.pending_actions,
                  color: isCompleted ? Colors.green : Colors.blue.shade700,
                ),
                const SizedBox(width: 8),
                Text(
                  isCompleted ? 'Completed' : 'To Do',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            Text(
              isCompleted
                  ? 'This habit is currently in your Done list.'
                  : 'This habit is currently in your To Do list. Complete it with a swipe from the habit list.',
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),

            // Explicit back action required by the lab.
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Back to List'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
