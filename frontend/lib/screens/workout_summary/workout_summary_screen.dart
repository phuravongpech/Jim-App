import 'package:flutter/material.dart';
import 'package:frontend/screens/workout_summary/widget/workout_summary_list.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/action/jim_button.dart';
import 'package:frontend/widgets/action/jim_icon_button.dart';
import 'package:frontend/widgets/navigation/jim_top_bar.dart';

void main() {
  runApp(MaterialApp(
    home: WorkoutSummaryScreen(),
  ));
}

class WorkoutSummaryScreen extends StatelessWidget {
  final String appBarTitle = "Full Body Strength";
  final String duration = "11:00";
  final List<Map<String, dynamic>> exercises = [
    {
      "name": "Deadlift",
      "setNumber": 4,
      "setCount": 4,
      "imageUrl": "https://v2.exercisedb.io/image/Rcp-zoSdFZbzfb"
    },
    {
      "name": "Squat",
      "setNumber": 4,
      "setCount": 4,
      "imageUrl": "https://v2.exercisedb.io/image/Rcp-zoSdFZbzfb"
    },
    {
      "name": "Bench Press",
      "setNumber": 4,
      "setCount": 4,
      "imageUrl": "https://v2.exercisedb.io/image/Rcp-zoSdFZbzfb"
    },
    {
      "name": "Deadlift",
      "setNumber": 4,
      "setCount": 2,
      "imageUrl": "https://v2.exercisedb.io/image/Rcp-zoSdFZbzfb"
    },
    {
      "name": "Squat",
      "setNumber": 4,
      "setCount": 2,
      "imageUrl": "https://v2.exercisedb.io/image/Rcp-zoSdFZbzfb"
    },
    {
      "name": "Bench Press",
      "setNumber": 4,
      "setCount": 2,
      "imageUrl": "https://v2.exercisedb.io/image/Rcp-zoSdFZbzfb"
    },
    {
      "name": "Deadlift",
      "setNumber": 4,
      "setCount": 2,
      "imageUrl": "https://v2.exercisedb.io/image/Rcp-zoSdFZbzfb"
    },
    {
      "name": "Squat",
      "setNumber": 4,
      "setCount": 2,
      "imageUrl": "https://v2.exercisedb.io/image/Rcp-zoSdFZbzfb"
    },
    {
      "name": "Bench Press",
      "setNumber": 4,
      "setCount": 2,
      "imageUrl": "https://v2.exercisedb.io/image/Rcp-zoSdFZbzfb"
    },
  ];

  WorkoutSummaryScreen({super.key});
  bool get isWorkoutComplete {
    return exercises.every((exercise) => exercise['setCount'] == exercise['setNumber']);
  }

  void _finishWorkout(BuildContext context) {
    if (!isWorkoutComplete) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Workout Incomplete'),
          content: const Text('Are you sure you want to finish without completing all exercises?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      );
    } else {
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JimTopBar(
        title: appBarTitle,
        centerTitle: true,
        leading: JimIconButton(
          icon: Icons.arrow_back,
          onPressed: () {},
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(JimSpacings.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  duration,
                  style: JimTextStyles.title,
                ),
                SizedBox(height: JimSpacings.m),
                Text(
                  "Duration",
                  style: JimTextStyles.title,
                ),
                SizedBox(height: JimSpacings.m),
                
              ],
            ),
          ),
          Expanded(
            child: WorkoutSummaryList(exercises: exercises),
          ),
          Padding(
            padding: const EdgeInsets.all(JimSpacings.m),
            child: JimButton(
              text: "Finish Workout",
              onPressed: () => _finishWorkout(context),
              type: isWorkoutComplete ? ButtonType.primary : ButtonType.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
