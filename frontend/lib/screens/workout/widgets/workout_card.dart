import 'package:flutter/material.dart';
import 'package:frontend/common/theme.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String description;
  final int exercisesCount;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.description,
    required this.exercisesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColor.primaryBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColor.black,
          width: 1, // Border width
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(
                  Icons.fitness_center,
                  size: 16,
                  color: Colors.black,
                ),
                const SizedBox(width: 8),
                Text(
                  '$exercisesCount exercises',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
