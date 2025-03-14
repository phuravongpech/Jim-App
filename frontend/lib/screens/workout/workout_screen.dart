import 'package:flutter/material.dart';
import 'package:frontend/screens/workout/widgets/workout_card.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/display/jim_list_view.dart';
import 'package:frontend/widgets/navigation/jim_top_bar.dart';
import 'package:get/get.dart';

import '../../../controller/workout_controller.dart';
import '../../widgets/action/jim_text_button.dart';
import '../../widgets/navigation/jim_nav_bar.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final WorkoutController workoutController =
      Get.put(WorkoutController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: JimTopBar(
        title: 'Workout',
        actions: [
          JimTextButton(
            text: 'Add',
            onPressed: () {
              Get.toNamed('/create-workout');
            },
          ),
        ],
      ),
      body: JimListView(
        items: workoutController.xWorkoutList,
        emptyMessage: "No Workouts Available!",
        itemBuilder: (workout) => GestureDetector(
          onTap: () {
            Get.toNamed('/workout-detail', arguments: workout.id);
          },
          child: WorkoutCard(
            title: workout.name,
            description: workout.description,
            exercisesCount: workout.exercises.length,
          ),
        ),
      ),
      bottomNavigationBar: JimNavBar(),
    );
  }
}
