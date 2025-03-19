import 'package:flutter/material.dart';
import 'package:frontend/controller/select_exercise_controller.dart';
import 'package:frontend/controller/workout_controller.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/screens/workout/widgets/rest_time_picker.dart';
import 'package:frontend/screens/workout/widgets/set_button.dart';
import 'package:frontend/widgets/action/jim_button.dart';
import 'package:frontend/widgets/action/jim_icon_button.dart';
import 'package:frontend/widgets/action/jim_text_button.dart';
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

  void onPressedAddExercise() async {
    final result = await Get.toNamed('/select-exercises');

    // If the result is not null, update the selected exercises
    if (result != null) {
      // Convert the result (List<Exercise>) to a list of WorkoutExercise objects
      final newExercises = (result as List<Exercise>).map((exercise) {
        return WorkoutExercise(
          exerciseId: exercise.id,
          setCount: 4,
          restTimeSecond: 90,
        );
      }).toList();

      // Add the new exercises to the existing list in the controller
      controller.addExercises(newExercises);
    }
  }

  void handleDismissedExercise(BuildContext context, int index) {
    final removedExercise = controller.exercises[index];
    // Remove the exercise
    controller.removeExercise(index);

    // Show SnackBar for undo
    Get.snackbar(
      'Exercise removed',
      'You can undo this action',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: JimColors.error,
      colorText: JimColors.white,
      mainButton: TextButton(
        onPressed: () {
          // Undo the removal
          controller.exercises.insert(index, removedExercise);
          controller.update();
        },
        child: Text(
          'UNDO',
          style: JimTextStyles.body
              .copyWith(color: JimColors.primary, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize exercises with the arguments passed
    final exercises = Get.arguments as List<WorkoutExercise>;
    controller.initializeExercises(exercises);

    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: _buildAppBar(),
      body: _buildExerciseList(),
      bottomNavigationBar: _buildAddExerciseButton(),
    );
  }

  JimTopBar _buildAppBar() {
    return JimTopBar(
      title: 'Edit Exercise',
      leading: JimIconButton(
        icon: Icons.arrow_back,
        color: JimColors.textPrimary,
        onPressed: () {
          Get.back();
        },
      ),
      actions: [
        JimTextButton(
          text: 'Save',
          onPressed: () {
            Get.back(result: controller.getUpdatedExercises());
          },
        ),
      ],
    );
  }

  Widget _buildExerciseList() {
    return Obx(() {
      return ReorderableListView.builder(
        itemCount: controller.exercises.length,
        buildDefaultDragHandles: false,
        itemBuilder: (context, index) {
          final exercise = controller.exercises[index];
          final exerciseId = exercise.exerciseId;
          final Exercise? fullExercise = selectExerciseController.getExerciseById(exerciseId);

          if (fullExercise == null) {
            return Container(); // Handle null case
          }

          return Dismissible(
            key: Key(exerciseId), // Unique key for each item
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              color: JimColors.error,
              padding: const EdgeInsets.only(right: JimSpacings.m + 4),
              child: Icon(Icons.delete, color: JimColors.white),
            ),
            onDismissed: (direction) {
              handleDismissedExercise(context, index);
            },
            child: Padding(
              key: Key(exerciseId), // Unique key for reordering
              padding: const EdgeInsets.symmetric(
                  vertical: JimSpacings.xs, horizontal: JimSpacings.m),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(JimSpacings.radius),
                  color: JimColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(JimSpacings.m),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Reorderable Drag Handle
                      ReorderableDragStartListener(
                        index: index,
                        child: Padding(
                          padding: const EdgeInsets.only(right: JimSpacings.m),
                          child: Icon(Icons.menu, color: JimColors.whiteGrey),
                        ),
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
                      const SizedBox(width: JimSpacings.m),
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
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                // Decrease Set Button
                                SetButton(
                                  onPressed: () =>
                                      controller.decreaseSet(index),
                                  icon: Icons.remove,
                                ),
                                // Set Count
                                Text(
                                  exercise.setCount.toString(),
                                  style: JimTextStyles.body,
                                ),
                                // Increase Set Button
                                SetButton(
                                  onPressed: () =>
                                      controller.increaseSet(index),
                                  icon: Icons.add,
                                ),
                                Text('Sets', style: JimTextStyles.body),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Rest Time Icon and Value
                      Column(
                        children: [
                          JimIconButton(
                            icon: Icons.more_time_rounded,
                            color: JimColors.darkBlue,
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
                          // Display Rest Time
                          Text(
                            "${exercise.restTimeSecond}s",
                            style: JimTextStyles.body,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) {
            newIndex -= 1; // Adjust for the reordering behavior of the list
          }
          if (newIndex >= controller.exercises.length) {
            newIndex = controller.exercises.length - 1; // Ensure valid index
          }
          controller.reorderExercises(oldIndex, newIndex);
        },
      );
    });
  }

  Widget _buildAddExerciseButton() {
    return Padding(
      padding: const EdgeInsets.all(JimSpacings.m),
      child: JimButton(
        text: 'Add Exercise',
        onPressed: onPressedAddExercise,
        type: ButtonType.primary,
        icon: Icons.add,
      ),
    );
  }
}
