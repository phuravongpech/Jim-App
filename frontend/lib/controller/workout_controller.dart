import 'package:frontend/controller/edit_exercise_controller.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/services/workout_service.dart';
import 'package:get/get.dart';

import '../models/workout.dart';
import '../models/workout_with_exercise.dart';

class WorkoutController extends GetxController {
  var xWorkoutTitle = ''.obs;
  var xWorkoutDescription = ''.obs;
  var xSelectedExercises = <Exercise>[].obs; // List of selected exercise IDs
  var xWorkoutList = <Workout>[].obs; // List to store workouts
  var workout = Rxn<Workout>(); // Store workout details

  final service = WorkoutService.instance;

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
      final fetchedWorkouts =
          await WorkoutService.instance.getWorkoutWithExercises();
      xWorkoutList.assignAll(fetchedWorkouts);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load workouts: $e');
    }
  }

  // Fetch workout details by ID
  void fetchWorkoutDetail(String id) async {
    try {
      WorkoutWithExercise fetchedWorkout =
          await WorkoutService.instance.getWorkoutWithExercisesFor(id);
      workout.value = Workout(
          id: id,
          name: fetchedWorkout.name,
          description: fetchedWorkout.description,
          exerciseCount: fetchedWorkout.workoutExercises.length);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load workout details: $e');
    }
  }

  fetchExercises() async {
    try {
      final fetchedExercises =
          await WorkoutService.instance.getWorkoutWithExercises();

      // Add the fetched exercises to the list
      xWorkoutList.addAll(fetchedExercises);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load workouts: $e');
    }
  }

  // Save the workout data and perform validation
  void saveWorkout() async{
    final EditExerciseController editExerciseController =
        Get.put(EditExerciseController());

    try {
    // Save the workout and get the response from the backend
    final savedWorkoutId = await WorkoutService.instance.saveWorkout(
      name: xWorkoutTitle.value,
      description: xWorkoutDescription.value,
      exercises: xSelectedExercises.toList(),
      workoutExercises: editExerciseController.exercises,
    );

    // Create a new workout object with the returned ID
    final newWorkout = Workout(
      id: savedWorkoutId, // Use the ID returned by the backend
      name: xWorkoutTitle.value,
      description: xWorkoutDescription.value,
      exerciseCount: xSelectedExercises.length,
    );

    // Add the new workout to the list
    xWorkoutList.add(newWorkout);

    // Clear the form fields after saving
    xWorkoutTitle.value = '';
    xWorkoutDescription.value = '';
    xSelectedExercises.clear();

    // Exit create workout form
    Get.back();
  } catch (e) {
    Get.snackbar('Error', 'Failed to save workout: ${e.toString()}');
  }
}

  Future<void> deleteWorkout(String workoutId) async {
    try {
      await service.deleteWorkout(workoutId);
      xWorkoutList.removeWhere((workout) => workout.id == workoutId);
      Get.snackbar('Success', 'Workout deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete workout: ${e.toString()}');
      throw Exception('Failed to delete workout: $e');
    }
  }
}
