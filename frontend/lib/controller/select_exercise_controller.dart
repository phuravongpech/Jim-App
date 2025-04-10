import 'package:frontend/models/exercise.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

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

  final log = Logger();

  @override
  void onInit() {
    super.onInit();
    final initialSelectedIds = Get.arguments as List<String>? ?? [];
    selectedExercises.value = Set.from(initialSelectedIds);
    fetchExercises();
  }

  void setInitialSelectedExercises(List<String> initialIds) {
    selectedExercises.value = Set.from(initialIds);
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
        offset: page.value,
        limit: limit,
      );

      if (fetchedExercises.isNotEmpty) {
        exercises.addAll(fetchedExercises); // Add fetched exercises to the list
        allExercises.addAll(fetchedExercises); // Populate allExercises
        page.value += 10; // Increment the page for the next fetch
      } else if (reset) {
        log.i('No more exercises available.');
      } else {
        log.i('No more exercises available for the current filter.');
      }
    } catch (e) {
      log.e('Error fetching exercises: $e');
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }

  /// Searches exercises by name.
  Future<void> searchExercises(String query) async {
    if (query.isEmpty) {
      fetchExercises(reset: true);
      return;
    }

    if (isLoading.value) return;

    try {
      isLoading.value = true;

      // Clear previous results
      exercises.clear();
      allExercises.clear();
      page.value = 0;

      final searchedExercises = await ExerciseService.instance.searchExercises(
        query: query,
        page: page.value,
        limit: limit,
      );

      if (searchedExercises.isNotEmpty) {
        exercises.addAll(searchedExercises);
        allExercises.addAll(searchedExercises);
        page.value += 10;
      } else {
        log.i('No search results.');
      }
    } catch (e) {
      exercises.clear();
      log.e('Error searching exercises: $e');
    } finally {
      isLoading.value = false;
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

  Exercise? getExerciseById(String id) {
    try {
      return allExercises.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }
}
