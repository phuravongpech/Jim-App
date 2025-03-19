import 'package:get/get.dart';
import '../models/workout_exercise.dart';

class EditExerciseController extends GetxController {
  var exercises = <WorkoutExercise>[].obs;

  /// Initialize the exercises
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
        setCount: exercises[index].setCount + 1,
        restTimeSecond: exercises[index].restTimeSecond,
      );
    }
  }

  void decreaseSet(int index) {
    if (index >= 0 && index < exercises.length && exercises[index].setCount > 1) {
      exercises[index] = WorkoutExercise(
        exerciseId: exercises[index].exerciseId,
        setCount: exercises[index].setCount - 1,
        restTimeSecond: exercises[index].restTimeSecond,
      );
    }
  }

  // Update rest time
  void updateRestTime(int index, int newRestTime) {
    if (index >= 0 && index < exercises.length) {
      exercises[index] = WorkoutExercise(
        exerciseId: exercises[index].exerciseId,
        setCount: exercises[index].setCount,
        restTimeSecond: newRestTime,
      );
    }
  }

  // Remove an exercise at the specified index
  void removeExercise(int index) {
    if (index >= 0 && index < exercises.length) {
      exercises.removeAt(index);
    }
  }

  // Reorder exercises
  void reorderExercises(int oldIndex, int newIndex) {
    if (oldIndex < 0 ||
        oldIndex >= exercises.length ||
        newIndex < 0 ||
        newIndex > exercises.length) {
      return;
    }

    /// Remove the exercise from the old index and insert it at the new index
    final exercise = exercises.removeAt(oldIndex);
    exercises.insert(newIndex, exercise);
  }

  List<WorkoutExercise> getUpdatedExercises() {
    return exercises;
  }
}
