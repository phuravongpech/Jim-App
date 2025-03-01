import 'package:flutter/material.dart';
import 'package:frontend/common/theme.dart';
import 'package:get/get.dart';

class CreateWorkoutScreen extends StatelessWidget {
  const CreateWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackground,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Workout Title',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColor.textPrimary),
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Input Workout Title',
                labelStyle: TextStyle(
                    color: AppColor.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Description (Optional)',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColor.textPrimary),
            ),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Description...',
                labelStyle: TextStyle(
                    color: AppColor.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Add exercises
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Exercises',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed('/select-exercises');
                  },
                  icon: const Icon(
                    Icons.add,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // validate empty exercise and display exercises if selected
            Expanded(
              child: Center(
                child: Text(
                  'No exercises added yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.textSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar _buildAppBar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: AppColor.white,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: AppColor.black,
      ),
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
        onPressed: () {},
        child: const Text(
          'Save',
          style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    ],
  );
}
