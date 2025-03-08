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
      if (!exercises.any((exercise) => exercise.exerciseId == newExercise.exerciseId)) {
        exercises.add(newExercise);
      }
    }
  }

  List<WorkoutExercise> getUpdatedExercises() {
    return exercises;
  }

  void decreaseSet(int index) {
    if (exercises[index].set > 1) {
      exercises[index].set--;
    }
  }

  void increaseSet(int index) {
    exercises[index].set++;
  }
}