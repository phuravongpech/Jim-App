import 'package:flutter/material.dart';
import 'package:frontend/models/exercise.dart';
import 'package:get/get.dart';

import '../../common/theme.dart';

class EditExerciseScreen extends StatefulWidget {
  const EditExerciseScreen({super.key, required Exercise exercise});

  @override
  State<EditExerciseScreen> createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackground,
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildAddButton(),
    );
  }
}

AppBar _buildAppBar() {
  return AppBar(
    backgroundColor: AppColor.white,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: AppColor.black),
      onPressed: () {
        Get.offNamed('/create-workout');
      },
    ),
    title: const Text(
      'Edit Exercise',
      style: TextStyle(
        color: AppColor.black,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildAddButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: ElevatedButton.icon(
      onPressed: () {
        Get.toNamed('/select-exercises');
      },
      icon: const Icon(
        Icons.add,
        color: AppColor.white,
      ),
      label: const Text('Add Exercises'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
