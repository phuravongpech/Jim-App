import 'package:flutter/material.dart';
import 'package:frontend/common/theme.dart';
import 'package:get/get.dart';

import '../../../controller/select_exercise_controller.dart';
import '../../../controller/workout_controller.dart';
import '../../../models/exercise.dart';

class WorkoutForm extends StatelessWidget {
  WorkoutForm({super.key});

  final WorkoutController workoutController = Get.find<WorkoutController>();
  final SelectExerciseController selectExerciseController =
      Get.find<SelectExerciseController>();

  // Add GlobalKey for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Assign the key here
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Workout Title
          const Text(
            'Workout Title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColor.textPrimary,
            ),
          ),
          TextFormField(
            onChanged: (value) => workoutController.workoutTitle.value = value,
            decoration: const InputDecoration(
              hintText: 'Input Workout Title',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              // Check if title is empty or already exists
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }

              // if (workoutController.workoutTitle.value ==
              //     workoutController.previousTitle.value) {
              //   return 'This title is already used';
              // }

              return null;
            },
          ),
          const SizedBox(height: 16),

          // Workout Description
          const Text(
            'Description (Optional)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColor.textPrimary,
            ),
          ),
          TextField(
            onChanged: (value) =>
                workoutController.workoutDescription.value = value,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Description...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          // Exercises Section
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
              // Add Exercise Button
              IconButton(
                onPressed: () async {
                  // Navigate to the exercise selection screen
                  final result = await Get.toNamed('/select-exercises');
                  if (result != null) {
                    // Update the selected exercises in the workout controller
                    workoutController.selectedExercises.value =
                        List<String>.from(result);
                  }
                },
                icon: const Icon(
                  Icons.add,
                  color: AppColor.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // List of Selected Exercises
          SingleChildScrollView(
            child: Obx(() {
              if (workoutController.selectedExercises.isEmpty) {
                return Center(
                  child: Text(
                    'No exercises added yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.error,
                    ),
                  ),
                );
              }

              return SizedBox(
                height: 500,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: workoutController.selectedExercises.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final exerciseId =
                        workoutController.selectedExercises[index];
                    final Exercise? exercise =
                        selectExerciseController.getExerciseById(exerciseId);

                    // If the exercise is not found, return an empty container
                    if (exercise == null) {
                      return Container();
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          // Menu/Edit Icon
                          IconButton(
                            icon: const Icon(Icons.menu, color: Colors.grey),
                            onPressed: () {
                              // Handle edit action
                            },
                          ),

                          // Exercise Image
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(exercise.gifUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Exercise Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exercise.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      "4 sets",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColor.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "90s",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColor.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Delete Button
                          IconButton(
                            icon:
                                const Icon(Icons.delete, color: AppColor.error),
                            onPressed: () =>
                                workoutController.removeExercise(exerciseId),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
