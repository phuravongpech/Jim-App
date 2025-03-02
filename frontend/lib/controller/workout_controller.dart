import 'package:get/get.dart';

class WorkoutController extends GetxController {
  var workoutTitle = ''.obs;
  var workoutDescription = ''.obs;
  var selectedExercises = <String>[].obs; // List of selected exercise IDs
  var workoutList = <Map<String, dynamic>>[].obs; // List to store workouts

  // Add an exercise to the selected exercises list
  void addExercise(String exercise) {
    selectedExercises.add(exercise);
  }

  // Remove an exercise from the selected exercises list
  void removeExercise(String exercise) {
    selectedExercises.remove(exercise);
  }

  // Save the workout data and perform validation
  void saveWorkout() {
    if (workoutTitle.value.isEmpty) {
      Get.snackbar('Error', 'Workout Title is required!');
      return;
    }

    if (selectedExercises.isEmpty) {
      Get.snackbar('Error', 'At least one exercise must be added!');
      return;
    }

    // Create the workout data
    final workoutData = {
      'title': workoutTitle.value,
      'description': workoutDescription.value,
      'exercises': selectedExercises.toList(),
    };

    // Add the workout to the list
    addWorkout(workoutData);

    // Clear the form fields after saving
    workoutTitle.value = '';
    workoutDescription.value = '';
    selectedExercises.clear();

    // Return the workout data when saved
    Get.back(result: workoutData);
  }

  // Add a new workout to the list
  void addWorkout(Map<String, dynamic> workoutData) {
    workoutList.add(workoutData);
  }

  // Optionally, remove a workout by title
  void removeWorkout(String title) {
    workoutList.removeWhere((workout) => workout['title'] == title);
  }
}
