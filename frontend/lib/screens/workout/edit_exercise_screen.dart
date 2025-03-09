import 'package:flutter/material.dart';
import 'package:frontend/controller/select_exercise_controller.dart';
import 'package:frontend/controller/workout_controller.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/screens/workout/widgets/rest_time_picker.dart';
import 'package:frontend/widgets/action/jim_button.dart';
import 'package:frontend/widgets/navigation/jim_top_bar.dart';
import 'package:get/get.dart';
import '../../controller/edit_exercise_controller.dart';
import '../../models/workout_exercise.dart';
import '../../theme/theme.dart';

class EditExerciseScreen extends StatelessWidget {
  final EditExerciseController controller = Get.put(EditExerciseController());
  final WorkoutController workoutController = Get.find<WorkoutController>();
  final SelectExerciseController selectExerciseController =
      Get.find<SelectExerciseController>();

  EditExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize exercises with the arguments passed
    final exercises = Get.arguments as List<WorkoutExercise>;
    controller.initializeExercises(exercises);

    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: _buildAppBar(),
      body: _buildExerciseList(),
      bottomNavigationBar:
          _buildAddExerciseButton(), // Use the corrected method here
    );
  }

  JimTopBar _buildAppBar() {
    return JimTopBar(
      title: 'Edit Exercise',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: JimColors.textPrimary),
        onPressed: () {
          Get.back();
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(result: controller.getUpdatedExercises());
          },
          child: const Text(
            'Save',
            style: TextStyle(
              color: JimColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExerciseList() {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.exercises.length,
        itemBuilder: (context, index) {
          final exercise = controller.exercises[index];
          final exerciseId = exercise.exerciseId;
          final Exercise? fullExercise =
              selectExerciseController.getExerciseById(exerciseId);

          if (fullExercise == null) {
            return Container(); // Handle null case
          }

          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag Handle Icon (Optional)
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Icon(Icons.drag_handle, color: Colors.grey),
                    ),
                    // Exercise Image
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(JimSpacings.radiusSmall),
                        image: DecorationImage(
                          image: NetworkImage(fullExercise.gifUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    // Exercise Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Exercise Name
                          Text(
                            fullExercise.name,
                            style: JimTextStyles.body.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              // Decrease Set Button
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () => controller.decreaseSet(index),
                                splashRadius: 20,
                                color: Colors.grey,
                              ),
                              // Set Count
                              Text(
                                "${exercise.set} Sets",
                                style: JimTextStyles.body,
                              ),
                              // Increase Set Button
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () => controller.increaseSet(index),
                                splashRadius: 20,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Rest Time Icon and Value
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.timer, color: Colors.blue),
                          onPressed: () async {
                            final newRestTime = await Get.to<int>(
                              RestTimePicker(
                                initialRestTime: exercise.restTimeSecond,
                                exerciseIndex: index,
                              ),
                            );

                            if (newRestTime != null) {
                              controller.updateRestTime(index, newRestTime);
                            }
                          },
                        ),
                        const SizedBox(height: 4.0),
                        // Display Rest Time
                        Text(
                          "${exercise.restTimeSecond}s",
                          style:
                              JimTextStyles.body.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildAddExerciseButton() {
    return Padding(
      padding: const EdgeInsets.all(JimSpacings.m),
      child: JimButton(
        text: 'Add Exercise',
        onPressed: () async {
          // Navigate to SelectExerciseScreen and wait for the result
          final result = await Get.toNamed('/select-exercises');

          // If the result is not null, update the selected exercises
          if (result != null) {
            // Convert the result (List<Exercise>) to a list of WorkoutExercise objects
            final newExercises = (result as List<Exercise>).map((exercise) {
              return WorkoutExercise(
                exerciseId: exercise.id,
                set: 4,
                restTimeSecond: 90,
              );
            }).toList();

            // Add the new exercises to the existing list in the controller
            controller.addExercises(newExercises);
          }
        },
        type: ButtonType.primary,
        icon: Icons.add,
      ),
    );
  }
}
