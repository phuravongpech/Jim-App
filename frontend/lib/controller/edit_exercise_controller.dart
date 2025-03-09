import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/workout_exercise.dart';

class EditExerciseController extends GetxController with SingleGetTickerProviderMixin {
  var exercises = <WorkoutExercise>[].obs;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void onInit() {
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Initialize animation
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start animation when the controller is initialized
    _animationController.forward();
    super.onInit();
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }

  void initializeExercises(List<WorkoutExercise> initialExercises) {
    exercises.assignAll(initialExercises);
  }

  void addExercises(List<WorkoutExercise> newExercises) {
    for (var newExercise in newExercises) {
      // Check if the exercise already exists in the list
      if (!exercises
          .any((exercise) => exercise.exerciseId == newExercise.exerciseId)) {
        exercises.add(newExercise);
      }
    }
  }

  void increaseSet(int index) {
    if (index >= 0 && index < exercises.length) {
      exercises[index] = WorkoutExercise(
        exerciseId: exercises[index].exerciseId,
        set: exercises[index].set + 1,
        restTimeSecond: exercises[index].restTimeSecond,
      );
    }
  }

  void decreaseSet(int index) {
    if (index >= 0 && index < exercises.length && exercises[index].set > 1) {
      exercises[index] = WorkoutExercise(
        exerciseId: exercises[index].exerciseId,
        set: exercises[index].set - 1,
        restTimeSecond: exercises[index].restTimeSecond,
      );
    }
  }

  // New method to update rest time
  void updateRestTime(int index, int newRestTime) {
    if (index >= 0 && index < exercises.length) {
      exercises[index] = WorkoutExercise(
        exerciseId: exercises[index].exerciseId,
        set: exercises[index].set,
        restTimeSecond: newRestTime,
      );
      // Trigger animation when the rest time changes
      _animationController.reset();
      _animationController.forward();
    }
  }

  List<WorkoutExercise> getUpdatedExercises() {
    return exercises;
  }

  // Getter for animation
  Animation<double> get animation => _animation;
}
