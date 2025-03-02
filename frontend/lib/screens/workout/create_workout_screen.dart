import 'package:flutter/material.dart';
import 'package:frontend/common/theme.dart';
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
      backgroundColor: AppColor.primaryBackground,
      appBar: _buildAppBar(controller),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
    backgroundColor: AppColor.white,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: AppColor.black),
      onPressed: () {
        Get.back();
      },
    ),
    title: const Text(
      'Create Workout',
      style: TextStyle(
        color: AppColor.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          if (controller.workoutTitle.isEmpty) {
            Get.snackbar(
              'Error',
              'Please Input Workout Title',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColor.error,
              colorText: Colors.white,
            );
            return;
          }

          if (controller.selectedExercises.isEmpty) {
            Get.snackbar(
              'Error',
              'Please add at least one exercise.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColor.error,
              colorText: Colors.white,
            );
            return;
          }
          // Trigger save logic in controller
          controller.saveWorkout();
        },
        child: const Text(
          'Save',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}
