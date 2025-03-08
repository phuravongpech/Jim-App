import 'package:flutter/material.dart';
import 'package:frontend/models/workout_exercise.dart';
import 'package:get/get.dart';

import '../../../controller/select_exercise_controller.dart';
import '../../../controller/workout_controller.dart';
import '../../../models/exercise.dart';
import '../../../theme/theme.dart';

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
          Text(
            'Workout Title',
            style: JimTextStyles.subBody.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: JimColors.textPrimary,
            ),
          ),
          TextFormField(
            onChanged: (value) => workoutController.xWorkoutTitle.value = value,
            decoration: InputDecoration(
              hintText: 'Input Workout Title',
              border: OutlineInputBorder(),
              hintStyle: JimTextStyles.subBody
                  .copyWith(color: JimColors.textSecondary),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }

              return null;
            },
          ),
          const SizedBox(height: JimSpacings.s),

          // Workout Description
          Text(
            'Description (Optional)',
            style: JimTextStyles.subBody.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: JimColors.textPrimary,
            ),
          ),
          TextField(
            onChanged: (value) =>
                workoutController.xWorkoutDescription.value = value,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Description...',
              border: OutlineInputBorder(),
              hintStyle: JimTextStyles.subBody
                  .copyWith(color: JimColors.textSecondary),
            ),
          ),
          const SizedBox(height: JimSpacings.l),
          // Exercises Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Exercises',
                style: JimTextStyles.title,
              ),
              Obx(() => IconButton(
                    onPressed: () async {
                      // Navigate based on whether exercises have been selected
                      final result = await Get.toNamed(
                        workoutController.xSelectedExercises.isEmpty
                            ? '/select-exercises' // Navigate to select exercises if none are selected
                            : '/edit-exercises', // Navigate to edit exercises if already selected
                        arguments: workoutController.xSelectedExercises
                            .map((exercise) {
                          return WorkoutExercise(
                            exerciseId: exercise.id,
                            set: 4,
                            restTimeSecond: 90,
                          );
                        }).toList(),
                      );

                      // Update selected exercises when returning from the screen
                      if (result != null) {
                        workoutController.xSelectedExercises.value =
                            List<Exercise>.from(result);
                      }
                    },
                    icon: Icon(
                      // Show "Add" icon if no exercises are selected, otherwise "Edit"
                      workoutController.xSelectedExercises.isEmpty
                          ? Icons.add // Display Add icon
                          : Icons.edit, // Display Edit icon
                      size: JimIconSizes.medium,
                      color: JimColors.primary,
                    ),
                  )),
            ],
          ),
          const SizedBox(height: JimSpacings.s),

          // List of Selected Exercises
          SingleChildScrollView(
            child: Obx(() {
              if (workoutController.xSelectedExercises.isEmpty) {
                return Center(
                  child: Text(
                    'No exercises added yet',
                    style: JimTextStyles.body.copyWith(
                      fontSize: 16,
                      color: JimColors.error,
                    ),
                  ),
                );
              }

              return SizedBox(
                height: 500,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: workoutController.xSelectedExercises.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final exerciseId =
                        workoutController.xSelectedExercises[index].id;

                    final Exercise? exercise =
                        selectExerciseController.getExerciseById(exerciseId);

                    if (exercise == null) {
                      return Container();
                    }

                    // Create a WorkoutExercise instance dynamically
                    final workoutExercise = WorkoutExercise(
                      exerciseId: exercise.id,
                      set: 4,
                      restTimeSecond: 90,
                    );

                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: JimSpacings.s),
                      child: Row(
                        children: [
                          // Menu/Edit Icon
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              size: JimIconSizes.small,
                              color: JimColors.textSecondary,
                            ),
                            onPressed: () {
                              // Handle edit action
                            },
                          ),

                          // Exercise Image
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  JimSpacings.radiusSmall),
                              image: DecorationImage(
                                image: NetworkImage(exercise.gifUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: JimSpacings.s),

                          // Exercise Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exercise.name,
                                  style: JimTextStyles.body.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: JimColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: JimSpacings.xs),
                                Row(
                                  children: [
                                    Text(
                                      "${workoutExercise.set} sets",
                                      style: JimTextStyles.subBody.copyWith(
                                        fontSize: 14,
                                        color: JimColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(width: JimSpacings.s),
                                    Text(
                                      "${workoutExercise.restTimeSecond}s",
                                      style: JimTextStyles.subBody.copyWith(
                                        fontSize: 14,
                                        color: JimColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Delete Button
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: JimIconSizes.small,
                              color: JimColors.error,
                            ),
                            onPressed: () =>
                                workoutController.removeExercise(exercise),
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