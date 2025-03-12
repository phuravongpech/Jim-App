import 'package:flutter/material.dart';
import 'package:frontend/screens/workout_complete/widget/exercise_completion_icon.dart';
import 'package:frontend/screens/workout_complete/widget/exercise_info.dart';
import 'package:frontend/screens/workout_complete/widget/exercise_set.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/action/jim_icon_button.dart';
import 'package:frontend/widgets/navigation/jim_top_bar.dart';

class ExerciseSummaryScreen extends StatelessWidget {
  final String workoutName;
  final String date;
  final int time;
  final List<Map<String, dynamic>> exercises;

  const ExerciseSummaryScreen({
    super.key,
    required this.workoutName,
    required this.date,
    required this.time,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JimTopBar(
        title: workoutName,
        actions: [
          JimIconButton(
            icon: Icons.close,
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JimSpacings.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExerciseInfo(date: date, time: time),
              ExerciseCompletionIcon(),
              SizedBox(height: JimSpacings.l),
              for (var exercise in exercises)
                ExerciseSet(exercise: exercise),
            ],
          ),
        ),
      ),
    );
  }
}
