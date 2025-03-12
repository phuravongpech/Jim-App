import 'package:flutter/material.dart';
import 'package:frontend/controller/workout_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/models/workout.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/models/workout_exercise.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final WorkoutController controller = Get.put(WorkoutController());

  WorkoutDetailScreen({Key? key}) : super(key: key);

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.black),
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
