import 'package:get/get.dart';
import '../models/workout_exercise.dart';

class EditExerciseController extends GetxController {
  var exercises = <WorkoutExercise>[].obs;

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
    }
  }

  List<WorkoutExercise> getUpdatedExercises() {
    return exercises;
  }
}
