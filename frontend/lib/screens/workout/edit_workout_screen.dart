import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/action/jim_icon_button.dart';
import 'package:frontend/widgets/action/jim_text_button.dart';
import 'package:frontend/widgets/navigation/jim_top_bar.dart';
import 'package:get/get.dart';

import '../../controller/edit_workout_controller.dart';
import '../../controller/select_exercise_controller.dart';
import '../../models/workout_exercise.dart';

class EditWorkoutScreen extends StatefulWidget {
  final String workoutId;
  final EditWorkoutController controller;

  EditWorkoutScreen({super.key, required this.workoutId})
      : controller = Get.put(
          EditWorkoutController(workoutId: workoutId),
        );

  @override
  State<EditWorkoutScreen> createState() => _EditWorkoutScreenState();
}

class _EditWorkoutScreenState extends State<EditWorkoutScreen> {
  final EditWorkoutController controller = Get.find<EditWorkoutController>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // print("Workout ID: ${widget.workoutId}"); // Debugging purpose (woorkoutId true)
    _titleController =
        TextEditingController(text: controller.xWorkoutTitle.value);
    _descriptionController =
        TextEditingController(text: controller.xWorkoutDescription.value);

    // Listen to changes from controller
    ever(controller.xWorkoutTitle, (value) {
      if (value != _titleController.text) {
        _titleController.text = value;
      }
    });

    ever(controller.xWorkoutDescription, (value) {
      if (value != _descriptionController.text) {
        _descriptionController.text = value;
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void onPressedSaveWorkout() {
    if (controller.xWorkoutTitle.isEmpty) {
      Get.snackbar(
        'Error',
        'Please Input Workout Title',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: JimColors.error,
        colorText: JimColors.white,
      );
      return;
    }

    if (controller.xSelectedExercises.isEmpty) {
      Get.snackbar(
        'Error',
        'Please add at least one exercise.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: JimColors.error,
        colorText: JimColors.white,
      );
      return;
    }
    controller.updateWorkout(widget.workoutId).then((_) {
      Get.offNamed('/workout', arguments: {'refresh': true});
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SelectExerciseController());
    controller.fetchWorkoutDetail(widget.workoutId);
    print("Fetching details for Workout ID: ${widget.workoutId}");
    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: JimTopBar(
        title: 'Edit Workout',
        centerTitle: true,
        leading: JimIconButton(
          icon: Icons.arrow_back,
          color: JimColors.black,
          onPressed: () => Get.back(),
        ),
        actions: [
          JimTextButton(
            text: "Save",
            onPressed: onPressedSaveWorkout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JimSpacings.m),
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
              TextField(
                controller: _titleController,
                onChanged: (value) => controller.xWorkoutTitle.value = value,
                decoration: InputDecoration(
                  hintText: 'Input Workout Title',
                  border: OutlineInputBorder(),
                  hintStyle: JimTextStyles.subBody
                      .copyWith(color: JimColors.textSecondary),
                ),
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
                controller: _descriptionController,
                onChanged: (value) =>
                    controller.xWorkoutDescription.value = value,
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
                          final result = await Get.toNamed(
                            '/edit-exercises',
                            arguments: controller.workoutExercises.toList(),
                          );

                          if (result != null &&
                              result is List<WorkoutExercise>) {
                            // Update both the workout exercises and selected exercises
                            controller.updateExercises(result);

                            // Also update the edit exercise controller
                            controller.editExerciseController.exercises
                                .assignAll(result);
                          }
                        },
                        icon: controller.xSelectedExercises.isEmpty
                            ? Icons.add
                            : Icons.edit,
                        color: JimColors.primary,
                      )),
                ],
              ),
              const SizedBox(height: JimSpacings.s),

              // List of Selected Exercises
              Obx(() {
                if (controller.xSelectedExercises.isEmpty) {
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

                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.xSelectedExercises.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final exercise = controller.xSelectedExercises[index];
                    final workoutExercise =
                        controller.workoutExercises.firstWhere(
                      (e) => e.exerciseId == exercise.id,
                      orElse: () => WorkoutExercise(
                        exerciseId: exercise.id,
                        setCount: 4,
                        restTimeSecond: 90,
                      ),
                    );

                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: JimSpacings.s),
                      child: Row(
                        children: [
                          // Exercise Image (if available)
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  JimSpacings.radiusSmall),
                              color: JimColors.backgroundAccent,
                            ),
                            child: exercise.gifUrl != null
                                ? Image.network(
                                    exercise.gifUrl!,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(Icons.fitness_center,
                                    color: JimColors.primary),
                          ),
                          const SizedBox(width: JimSpacings.s),

                          // Exercise details
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
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
