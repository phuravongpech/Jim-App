import 'package:frontend/controller/edit_exercise_controller.dart';
import 'package:frontend/models/exercise.dart';
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
  var workout = Rxn<Workout>(); // Store workout details

  @override
  void onInit() {
    super.onInit();
    _workoutService = MockWorkoutService();
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
      final fetchedWorkouts = await _workoutService.getWorkouts();
      xWorkoutList.assignAll(fetchedWorkouts);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load workouts: $e');
    }
  }

  // Fetch workout details by ID
  void fetchWorkoutDetail(String id) async {
    try {
      Workout fetchedWorkout = await _workoutService.getWorkoutById(id);
      workout.value = fetchedWorkout;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load workout details: $e');
    }
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
    _workoutService.saveWorkouts(
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