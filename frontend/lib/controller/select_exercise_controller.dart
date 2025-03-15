import 'package:frontend/models/exercise.dart';
import 'package:get/get.dart';

import '../services/exercise_service.dart';

class SelectExerciseController extends GetxController {
  RxList<Exercise> exercises = <Exercise>[].obs; // List of exercises
  RxSet<String> selectedExercises =
      <String>{}.obs; // Set of selected exercise IDs
  RxBool isLoading = false.obs; // Loading state
  RxString selectedBodyPart = 'chest'.obs; // Selected body part filter
  RxInt page = 0.obs; // Pagination page
  final int limit = 10; // Number of exercises per page
  var allExercises = <Exercise>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchExercises(); // Fetch exercises on initialization
  }

  /// Fetches exercises from the service with pagination and filtering.
  Future<void> fetchExercises({bool reset = false}) async {
    if (reset) {
      exercises.clear(); // Clear the list if reset is true
      page.value = 0; // Reset pagination
    }

    if (isLoading.value) return; // Prevent multiple simultaneous fetches

    try {
      isLoading.value = true;

      // Fetch exercises from the service
      final fetchedExercises = await ExerciseService.instance.fetchExercises(
        page: page.value,
        limit: limit,
      );

      if (fetchedExercises.isNotEmpty) {
        exercises.addAll(fetchedExercises); // Add fetched exercises to the list
        allExercises.addAll(fetchedExercises); // Populate allExercises
        page.value++; // Increment the page for the next fetch
      } else if (reset) {
        Get.snackbar(
            'No Exercises', 'No exercises found for the selected body part.');
      } else {
        Get.snackbar('End of List', 'No more exercises available.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load exercises: $e');
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }

  /// Searches exercises by name.
  Future<void> searchExercises(String query) async {
    if (query.isEmpty) {
      fetchExercises(
          reset: true); // Reset and fetch all exercises if query is empty
      return;
    }

    if (isLoading.value) return; // Prevent multiple simultaneous searches

    try {
      isLoading.value = true;

      // Fetch all exercises (or a large number) for searching
      final allFetchedExercises = await ExerciseService.instance.fetchExercises(
        page: 0,
        limit: 100, // Adjust this limit as needed
      );

      // Filter exercises by name
      final filteredExercises = allFetchedExercises
          .where((exercise) =>
              exercise.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      // Update the exercises list with the filtered results
      exercises.value = filteredExercises;

      // Update the allExercises list with the fetched exercises
      allExercises.addAll(allFetchedExercises);

      if (exercises.isEmpty) {
        Get.snackbar('No Results', 'No exercises found for "$query".');
      }
    } catch (e) {
      exercises.clear(); // Clear the list on error
      Get.snackbar('Error', 'Failed to search exercises: $e');
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }

  /// Toggles the selection of an exercise.
  void toggleExerciseSelection(String exerciseId) {
    if (selectedExercises.contains(exerciseId)) {
      selectedExercises.remove(exerciseId); // Deselect if already selected
    } else {
      selectedExercises.add(exerciseId); // Select if not already selected
    }
  }

  /// Clears all selected exercises.
  void clearSelectedExercises() {
    selectedExercises.clear(); // Clear the set of selected exercises
  }

  /// Changes the selected body part and fetches exercises.
  void changeBodyPart(String bodyPart) {
    selectedBodyPart.value = bodyPart; // Update the selected body part
    fetchExercises(
        reset: true); // Reset and fetch exercises for the new body part
  }

  List<Exercise> getAllExercises() {
    return allExercises;
  }

  Exercise? getExerciseById(String id) {
    try {
      return allExercises.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Exercise> getSelectedExercises() {
    return selectedExercises
        .map((id) => allExercises.firstWhere((exercise) => exercise.id == id))
        .toList();
  }
}
