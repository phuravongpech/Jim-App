import 'package:frontend/models/exercise.dart';
import 'package:frontend/models/workout_exercise.dart';
import 'package:get/get.dart';

import '../models/workout.dart';
import '../repository/workout_repository.dart';
import '../services/mock_workout_service.dart';

class WorkoutController extends GetxController {
  //
  // Flag used for swicthing between mock service and real service
  //
  static bool useMock = true;

  late final WorkoutRepository _workoutService;

  var xWorkoutTitle = ''.obs;
  var xWorkoutDescription = ''.obs;
  var xSelectedExercises = <Exercise>[].obs; // List of selected exercise IDs
  var xWorkoutList = <Workout>[].obs; // List to store workouts

  @override
  void onInit() {
    super.onInit();
    _workoutService = MockWorkoutService();
    fetchExercises();
  }

  fetchExercises() async {
    try {
      final fetchedExercises = await _workoutService.getWorkouts();
      // Add the fetched exercises to the list
      xWorkoutList.addAll(fetchedExercises);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load workouts: $e');
    }
  }

  // Add an exercise to the selected exercises list
  void addExercise(Exercise exercise) {
    xSelectedExercises.add(exercise);
  }

  // Remove an exercise from the selected exercises list
  void removeExercise(Exercise exercise) {
    xSelectedExercises.remove(exercise);
  }

  // Save the workout data
  void saveWorkout() {
    if (xWorkoutTitle.value.isEmpty) {
      Get.snackbar('Error', 'Workout Title is required!');
      return;
    }

    if (xSelectedExercises.isEmpty) {
      Get.snackbar('Error', 'At least one exercise must be added!');
      return;
    }

    List<Exercise> exercises = xSelectedExercises;

    List<WorkoutExercise> workoutExercise = exercises.map((exercise) {
      return WorkoutExercise(exerciseId: exercise.id, set: 4, restTimeSecond: 90);
    }).toList();

    _workoutService.saveWorkouts(
        name: xWorkoutTitle.value,
        description: xWorkoutDescription.value,
        exercises: xSelectedExercises,
        workoutExercises: workoutExercise);

    xWorkoutTitle.value = '';
    xWorkoutDescription.value = '';
    xSelectedExercises.clear();
  }
}
