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
      body: Obx(() {
        if (controller.workout.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        
        final workout = controller.workout.value!;
        
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWorkoutHeader(workout),
                    _buildExercisesList(workout),
                  ],
                ),
              ),
            ),
            _buildStartWorkoutButton(workout),
          ],
        );
      }),
    );
  }

  Widget _buildWorkoutHeader(Workout workout) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            workout.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.fitness_center, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Text(
                '${workout.exercises.length} exercises',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            workout.description.isNotEmpty 
                ? workout.description 
                : 'Lorem ipsum is a dummy or placeholder text commonly used in graphic design,',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExercisesList(Workout workout) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Exercises',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to edit exercises screen
                  Get.toNamed('/select-exercises', arguments: workout);
                },
                child: Row(
                  children: [
                    Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green[400],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: Colors.green[400], size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: workout.exercises.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final exercise = workout.exercises[index];
            return _buildExerciseItem(exercise, workout);
          },
        ),
      ],
    );
  }

  Widget _buildExerciseItem(Exercise exercise, Workout workout) {
    // Get WorkoutExercise data based on exercise ID
    //final workoutExercise = _getWorkoutExerciseData(exercise.id, workout);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        children: [
          // Exercise image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              exercise.gifUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: const Icon(Icons.fitness_center, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          // Exercise details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Exercise details',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // // Helper method to get WorkoutExercise data for an exercise
  // WorkoutExercise _getWorkoutExerciseData(String exerciseId, Workout workout) {
  //   try {
  //     // Get workout exercises from the workout
  //     final workoutExercises = _getWorkoutExercises(workout);
      
  //     // if (workoutExercises.isNotEmpty) {
  //     //   return workoutExercises.firstWhere(
  //     //     (we) => we.id == exerciseId,
  //     //     orElse: () => WorkoutExercise(
  //     //       id: exerciseId, 
  //     //       restTimeSecond: 90, 
  //     //       setCount: 4
  //     //     ),
  //     //   );
  //     // }
  //   } catch (e) {
  //     // Handle any exceptions
  //     print('Error getting workout exercise data: $e');
  //   }
    
  //   // Default values if no workout exercise data is found
  //   return WorkoutExercise(id: exerciseId, restTimeSecond: 90, setCount: 4);
  // }
  
  // Helper method to extract workout exercises from workout object or arguments
  // List<WorkoutExercise> _getWorkoutExercises(Workout workout) {
  //   // Try to get workout exercises from arguments first
  //   if (Get.arguments is Map<String, dynamic> && 
  //       Get.arguments['workoutExercises'] != null) {
  //     try {
  //       final List<dynamic> workoutExercisesJson = Get.arguments['workoutExercises'];
  //       return workoutExercisesJson
  //           .map((json) => WorkoutExercise.fromJson(json))
  //           .toList();
  //     } catch (e) {
  //       print('Error parsing workout exercises from arguments: $e');
  //     }
  //   }
    
  //   // If workout has a property or getter for workoutExercises, use that
  //   try {
  //     if (workout.workoutExercises != null) {
  //       return workout.workoutExercises;
  //     }
  //   } catch (e) {
  //     print('Error accessing workout exercises from workout: $e');
  //   }
    
  //   // Return empty list if no workout exercises are found
  //   return [];
  // }

  Widget _buildStartWorkoutButton(Workout workout) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          // Navigate to start workout screen
          Get.toNamed('/start-workout', arguments: workout);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[400],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          minimumSize: const Size(double.infinity, 56),
        ),
        child: const Text(
          'Start Workout',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}