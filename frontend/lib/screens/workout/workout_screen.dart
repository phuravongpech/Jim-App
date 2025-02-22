import 'package:flutter/material.dart';
import 'package:frontend/common/theme.dart';
import 'package:frontend/screens/workout/widgets/workout_card.dart';
import 'package:frontend/widgets/ButtomNavigationBar/custom_bottom_navbar.dart';
import 'package:get/get.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final bool isWorkoutEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackground,
      appBar: _buildAppBar(),
      body: isWorkoutEmpty
          ? const Center(
              child: Text(
                'Empty Workout!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColor.error,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: 3,
              itemBuilder: (context, index) {
                return WorkoutCard();
              },
            ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
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
      IconButton(
        icon: const Icon(
          Icons.add_circle_outline,
          color: AppColor.black,
          size: 36,
        ),
        onPressed: () {
          Get.toNamed('/create-workout');
        },
      ),
    ],
  );
}
