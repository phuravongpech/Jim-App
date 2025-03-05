import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/screens/workout/widgets/workout_form.dart';
import 'package:get/get.dart';

import '../../controller/select_exercise_controller.dart';
import '../../controller/workout_controller.dart';

class CreateWorkoutScreen extends StatelessWidget {
  CreateWorkoutScreen({super.key});

  final WorkoutController controller = Get.put(WorkoutController());

  @override
  Widget build(BuildContext context) {
    Get.put(WorkoutController());
    Get.put(SelectExerciseController());

    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: _buildAppBar(controller),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JimSpacings.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WorkoutForm(),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar _buildAppBar(WorkoutController controller) {
  return AppBar(
    centerTitle: true,
    backgroundColor: JimColors.white,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: JimColors.black),
      onPressed: () {
        Get.back();
      },
    ),
    title: const Text(
      'Create Workout',
      style: TextStyle(
        color: JimColors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          if (controller.xWorkoutTitle.isEmpty) {
            Get.snackbar(
              'Error',
              'Please Input Workout Title',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: JimColors.error,
              colorText: JimColors.white,
            );
            return;
          }

          if (controller.xSelectedExercises.isEmpty) {
            Get.snackbar(
              'Error',
              'Please add at least one exercise.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: JimColors.error,
              colorText: JimColors.white,
            );
            return;
          }
          // Trigger save logic in controller
          controller.saveWorkout();
        },
        child: const Text(
          'Save',
          style: TextStyle(
            color: JimColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}