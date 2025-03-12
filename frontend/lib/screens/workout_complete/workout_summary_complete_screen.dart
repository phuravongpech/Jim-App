import 'package:flutter/material.dart';
import 'package:frontend/screens/workout_complete/exercise_summary.dart';

void main() {
  runApp(WorkoutSummaryCompleteScreen());
}

class WorkoutSummaryCompleteScreen extends StatefulWidget {
  const WorkoutSummaryCompleteScreen({super.key});

  @override
  State<WorkoutSummaryCompleteScreen> createState() =>
      _WorkoutSummaryCompleteScreenState();
}

class _WorkoutSummaryCompleteScreenState
    extends State<WorkoutSummaryCompleteScreen> {
  String workoutName = 'Full Body Strength';
  String date = 'Feb 12, 2025';
  int time = 45;
  List<Map<String, dynamic>> exercises = [
    {
      'name': 'Barbell Squats',
      'sets': [
        [1, 0, 0],
        [2, 0, 0],
        [3, 0, 0],
      ],
    },
    {
      'name': 'Dumbbell Bench Press',
      'sets': [
        [1, 8, 10],
        [2, 8, 10],
        [3, 8, 10],
      ],
    },
    {
      'name': 'Barbell Squats',
      'sets': [
        [1, 0, 0],
        [
          2,
          0,
          0,
        ],
        [3, 0, 0],
      ],
    },
    {
      'name': 'Dumbbell Bench Press',
      'sets': [
        [1, 8, 10],
        [2, 8, 10],
        [3, 8, 10],
      ],
    },
    {
      'name': 'Dumbbell Bench Press',
      'sets': [
        [1, 8, 10],
        [2, 8, 10],
        [3, 8, 10],
      ],
    },
    {
      'name': 'Dumbbell Bench Press',
      'sets': [
        [1, 8, 10],
        [2, 8, 10],
        [3, 8, 10],
      ],
    },
    {
      'name': 'Dumbbell Bench Press',
      'sets': [
        [1, 8, 10],
        [2, 8, 10],
        [3, 8, 10],
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExerciseSummaryScreen(
        workoutName: workoutName,
        date: date,
        time: time,
        exercises: exercises,
      ),
    );
  }
}

