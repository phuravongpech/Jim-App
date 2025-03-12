import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/action/jim_icon_button.dart';
import 'package:frontend/widgets/action/jim_text_button.dart';
import 'package:frontend/widgets/navigation/jim_top_bar.dart';
import 'package:get/get.dart';

import '../../controller/select_exercise_controller.dart';
import '../../controller/workout_controller.dart';
import '../../screens/workout/widgets/workout_form.dart';

class CreateWorkoutScreen extends StatelessWidget {
  CreateWorkoutScreen({super.key});

  final WorkoutController controller = Get.put(WorkoutController());

  void onPressedSaveWorkout() {
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
    controller.saveWorkout();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SelectExerciseController());

    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: JimTopBar(
        title: 'Create Workout',
        centerTitle: true,
        leading: JimIconButton(
          icon: Icons.arrow_back, color: JimColors.black,
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          JimTextButton(
            text: "Save",
            onPressed: onPressedSaveWorkout,
          ),
        ],
      ),
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
