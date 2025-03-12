import 'package:flutter/material.dart';
import 'package:frontend/screens/workout_summary/widget/exercise_details.dart';
import 'package:frontend/screens/workout_summary/widget/exercise_image.dart';
import 'package:frontend/theme/theme.dart';

class ExerciseTile extends StatelessWidget {
  final Map<String, dynamic> exercise;

  const ExerciseTile({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final int setCount = exercise['setCount'] ?? 0;
    final int setNumber = exercise['setNumber'];

    return Padding(
      padding: const EdgeInsets.all(JimSpacings.m),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ExerciseDetails(
              name: exercise['name'],
              setCount: setCount,
              setNumber: setNumber,
            ),
          ),
          const SizedBox(width: 16),
          ExerciseImage(imageUrl: exercise['imageUrl']),
        ],
      ),
    );
  }
}