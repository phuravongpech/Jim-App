import 'package:flutter/material.dart';
import 'package:frontend/controller/edit_exercise_controller.dart';
import 'package:frontend/models/workout_exercise.dart';
import 'package:frontend/widgets/action/jim_icon_button.dart';
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
  final EditExerciseController editExerciseController =
      Get.put(EditExerciseController());

  // Add GlobalKey for form validation
  final _formKey = GlobalKey<FormState>();

  Future<void> handleExerciseNavigation() async {
    // Determine the appropriate route and arguments
    final isSelectedEmpty = workoutController.xSelectedExercises.isEmpty;
    final routeName = isSelectedEmpty ? '/select-exercises' : '/edit-exercises';

    // Prepare arguments for the edit screen
    final arguments = isSelectedEmpty
        ? null
        : workoutController.xSelectedExercises.map((exercise) {
            // Check if the exercise already has edited values in the EditExerciseController
            final existingWorkoutExercise =
                editExerciseController.exercises.firstWhere(
              (e) => e.exerciseId == exercise.id,
              orElse: () => WorkoutExercise(
                exerciseId: exercise.id,
                setCount: 4,
                restTimeSecond: 90,
              ),
            );

            return existingWorkoutExercise;
          }).toList();

    // Initialize the EditExerciseController with the current exercises
    if (!isSelectedEmpty) {
      editExerciseController.initializeExercises(arguments!);
    }

    // Navigate to the screen and await the result
    final result = await Get.toNamed(routeName, arguments: arguments);

    // Process the result if it is not null
    if (result != null) {
      if (isSelectedEmpty) {
        // If coming from the SelectExerciseScreen, update the selected exercises
        final selectedExercises = result as List<Exercise>;
        workoutController.xSelectedExercises.value = selectedExercises;

        // Also Initialize the EditExerciseController with the newly selected exercises
        final newArguments = selectedExercises.map((exercise) {
          return WorkoutExercise(
            exerciseId: exercise.id,
            setCount: 4,
            restTimeSecond: 90,
          );
        }).toList();
        editExerciseController.initializeExercises(newArguments);
        
      } else {
        // If coming from the EditExerciseScreen, update the selected exercises
        final updatedExercises =
            (result as List<WorkoutExercise>).map((workoutExercise) {
          final exercise = selectExerciseController
              .getExerciseById(workoutExercise.exerciseId);
          if (exercise == null) {
            throw Exception(
                'Exercise not found for ID: ${workoutExercise.exerciseId}');
          }
          return exercise;
        }).toList();

        // Update the selected exercises in the WorkoutController
        workoutController.xSelectedExercises.value = updatedExercises;
      }
    }
  }

  /// Validate and clean the input
  String validateInput(String input) {
    return input.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

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
            onChanged: (value) {
              final cleanedValue = validateInput(value);
              workoutController.xWorkoutTitle.value = cleanedValue;
            },
            decoration: InputDecoration(
              hintText: 'Input Workout Title',
              border: OutlineInputBorder(),
              hintStyle: JimTextStyles.subBody
                  .copyWith(color: JimColors.textSecondary),
            ),
            validator: (value) {
              final cleanedValue = value == null ? '' : validateInput(value);
              // Check if the cleaned value is empty
              if (cleanedValue.isEmpty) {
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
              Obx(() => JimIconButton(
                    onPressed: () async {
                      await handleExerciseNavigation();
                    },
                    icon: workoutController.xSelectedExercises.isEmpty
                        ? Icons.add
                        : Icons.edit,
                    color: JimColors.primary,
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

                    // Get the edited workout exercise from the EditExerciseController
                    final workoutExercise =
                        editExerciseController.exercises.firstWhere(
                      (e) => e.exerciseId == exerciseId,
                      orElse: () => WorkoutExercise(
                        exerciseId: exerciseId,
                        setCount: 4,
                        restTimeSecond: 90,
                      ),
                    );

                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: JimSpacings.s),
                      child: Row(
                        children: [
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

                          // Exercise card items
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
                                      "${workoutExercise.setCount} sets",
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
