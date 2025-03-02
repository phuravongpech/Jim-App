import 'package:flutter/material.dart';
import 'package:frontend/common/theme.dart';
import 'package:frontend/screens/workout/widgets/workout_card.dart';
import 'package:frontend/widgets/ButtomNavigationBar/custom_bottom_navbar.dart';
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
      appBar: _buildAppBar(),
      body: Obx(() {
        if (workoutController.workoutList.isEmpty) {
          return const Center(
            child: Text(
              'No Workouts Available!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColor.error,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: workoutController.workoutList.length,
          itemBuilder: (context, index) {
            final workout = workoutController.workoutList[index];
            return WorkoutCard(
              title: workout['title'],
              description: workout['description'],
              exercisesCount: workout['exercises'].length,
            );
          },
        );
      }),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      title: const Text(
        'WORKOUT',
        style: TextStyle(
          color: AppColor.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.toNamed('/create-workout'); // Navigate to create workout page
          },
          child: Row(
            children: const [
              Text(
                'Add',
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 2),
              Icon(
                Icons.add,
                color: AppColor.primary,
                size: 28,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
