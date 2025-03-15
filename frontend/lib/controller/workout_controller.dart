import 'package:frontend/controller/edit_exercise_controller.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/services/workout_service.dart';
import 'package:get/get.dart';

import '../models/workout.dart';

class WorkoutController extends GetxController {
  var xWorkoutTitle = ''.obs;
  var xWorkoutDescription = ''.obs;
  var xSelectedExercises = <Exercise>[].obs; // List of selected exercise IDs
  var xWorkoutList = <Workout>[].obs; // List to store workouts
  var workout = Rxn<Workout>(); // Store workout details

  @override
  void onInit() {
    super.onInit();
    fetchExercises();
    fetchWorkouts();

    String? workoutId = Get.arguments;
    if (workoutId != null) {
      fetchWorkoutDetail(workoutId);
    }
  }

  // Fetch workouts
  void fetchWorkouts() async {
    try {
      final fetchedWorkouts = await WorkoutService.instance.fetchWorkouts();
      xWorkoutList.assignAll(fetchedWorkouts);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load workouts: $e');
    }
  }

  // Fetch workout details by ID
  void fetchWorkoutDetail(String id) async {
    try {
      Workout fetchedWorkout = await WorkoutService.instance.getWorkoutById(id);
      workout.value = fetchedWorkout;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load workout details: $e');
    }
  }

  fetchExercises() async {
    try {
      final fetchedExercises = await WorkoutService.instance.fetchWorkouts();

      // Add the fetched exercises to the list
      xWorkoutList.addAll(fetchedExercises);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load workouts: $e');
    }
  }

  // Save the workout data and perform validation
  void saveWorkout() {
    final EditExerciseController editExerciseController =
        Get.put(EditExerciseController());

    // Create a new workout object (UUID is generated automatically in the model)
    final newWorkout = Workout(
      name: xWorkoutTitle.value,
      description: xWorkoutDescription.value,
      exercises: xSelectedExercises.toList(),
    );

    // Create workout exercise relation
    WorkoutService.instance.saveWorkout(
        name: xWorkoutTitle.value,
        description: xWorkoutDescription.value,
        exercises: xSelectedExercises.toList(),
        workoutExercises: editExerciseController.exercises);

    // Add the new workout to the list
    xWorkoutList.add(newWorkout);

    // Clear the form fields after saving
    xWorkoutTitle.value = '';
    xWorkoutDescription.value = '';
    xSelectedExercises.clear();

    // Exit create workout form
    Get.back();
  }
}
