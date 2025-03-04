import 'package:flutter/material.dart';
import 'package:frontend/common/theme.dart';
import 'package:frontend/screens/workout/widgets/workout_card.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/navigation/custom_bottom_navbar.dart';
import 'package:frontend/widgets/display/jim_list_view.dart';
import 'package:frontend/widgets/navigation/jim_top_bar.dart';
import 'package:get/get.dart';

import '../../../controller/workout_controller.dart';

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
      backgroundColor: AppColor.primaryBackground,
      appBar: JimTopBar(
        title: 'Workout',
        actions: [
          TextButton(
              onPressed: () {
                Get.toNamed('/create-workout');
              },
              child: saveButton),
        ],
      ),
      body: JimListView(
        items: workoutController.xWorkoutList,
        emptyMessage: "No Workouts Available!",
        itemBuilder: (workout) => WorkoutCard(
          title: workout.name,
          description: workout.description,
          exercisesCount: workout.exercises.length,
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

Widget saveButton = Row(
  children: [
    Text(
      'Add',
      style: JimTextStyles.button,
    ),
    SizedBox(width: 2),
    Icon(
      Icons.add,
      color: AppColor.primary,
      size: 28,
    ),
  ],
);
