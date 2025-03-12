import 'package:flutter/material.dart';
import 'package:frontend/screens/workout_summary/widget/exercise_tile.dart';
import 'package:frontend/theme/theme.dart';

class WorkoutSummaryList extends StatelessWidget {
  final List<Map<String, dynamic>> exercises;

  const WorkoutSummaryList({super.key, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(JimSpacings.m),
      child: ListView.separated(
        itemCount: exercises.length,
        separatorBuilder: (context, index) => const Divider(
          thickness: 1,
          color: JimColors.stroke,
          height: JimSpacings.xl,
        ),
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return ExerciseTile(exercise: exercise);
        },
      ),
    );
  }
}





