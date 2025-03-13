import 'package:flutter/material.dart';
import 'package:frontend/controller/workout_controller.dart';
import 'package:frontend/widgets/action/jim_icon_button.dart';
import 'package:get/get.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final WorkoutController controller = Get.put(WorkoutController());

  WorkoutDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get workout ID from arguments if available
    final workoutId = Get.arguments is String ? Get.arguments : null;
    print(workoutId);
    // Fetch workout details if ID is provided
    if (workoutId != null && controller.workout.value == null) {
      controller.fetchWorkoutDetail(workoutId);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: JimIconButton(
          icon: Icons.arrow_back, color: Colors.black,
          onPressed: () => Get.back(),
        ),
        actions: [
          JimIconButton(
            icon: Icons.delete_outline, color: Colors.black,
            onPressed: () {
              // Delete workout logic here
              Get.back();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Workout Details will be shown here'),
      ),   
    );
  } 
}