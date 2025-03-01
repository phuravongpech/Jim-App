import 'package:flutter/material.dart';
import 'package:frontend/common/theme.dart';
import 'package:get/get.dart';

import '../../../controller/workout_controller.dart';

class WorkoutForm extends StatelessWidget {
  WorkoutForm({super.key});

  final WorkoutController controller = Get.put(WorkoutController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Workout Title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColor.textPrimary,
            ),
          ),
          Obx(() => TextField(
                onChanged: (value) => controller.workoutTitle.value = value,
                decoration: const InputDecoration(
                  hintText: 'Input Workout Title',
                  labelStyle: TextStyle(
                    color: AppColor.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  border: OutlineInputBorder(),
                ),
              )),
          const SizedBox(height: 24),
          const Text(
            'Description (Optional)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColor.textPrimary,
            ),
          ),
          Obx(() => TextField(
                maxLines: 3,
                onChanged: (value) =>
                    controller.workoutDescription.value = value,
                decoration: const InputDecoration(
                  hintText: 'Description...',
                  labelStyle: TextStyle(
                    color: AppColor.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  border: OutlineInputBorder(),
                ),
              )),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: controller.saveWorkout,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              foregroundColor: AppColor.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
