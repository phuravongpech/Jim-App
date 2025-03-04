import 'package:get/get.dart';

class WorkoutController extends GetxController {
  var xWorkoutTitle = ''.obs;
  var xWorkoutDescription = ''.obs;
  var xSelectedExercises = <String>[].obs; // List of selected exercise IDs
  var xWorkoutList = <Map<String, dynamic>>[].obs; // List to store workouts

  // Add an exercise to the selected exercises list
  void addExercise(String exercise) {
    xSelectedExercises.add(exercise);
  }

  // Remove an exercise from the selected exercises list
  void removeExercise(String exercise) {
    xSelectedExercises.remove(exercise);
  }

  // Save the workout data and perform validation
  void saveWorkout() {
    if (xWorkoutTitle.value.isEmpty) {
      Get.snackbar('Error', 'Workout Title is required!');
      return;
    }

    if (xSelectedExercises.isEmpty) {
      Get.snackbar('Error', 'At least one exercise must be added!');
      return;
    }

    // Create the workout data
    final workoutData = {
      'title': xWorkoutTitle.value,
      'description': xWorkoutDescription.value,
      'exercises': xSelectedExercises.toList(),
    };

    // Add the workout to the list
    addWorkout(workoutData);

    // Clear the form fields after saving
    xWorkoutTitle.value = '';
    xWorkoutDescription.value = '';
    xSelectedExercises.clear();

    // Return the workout data when saved
    Get.back(result: workoutData);
  }

  // Add a new workout to the list
  void addWorkout(Map<String, dynamic> workoutData) {
    xWorkoutList.add(workoutData);
  }

  // Optionally, remove a workout by title
  void removeWorkout(String title) {
    xWorkoutList.removeWhere((workout) => workout['title'] == title);
  }
}
