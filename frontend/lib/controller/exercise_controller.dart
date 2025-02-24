import 'package:frontend/models/exercise.dart';
import 'package:frontend/services/exercise_service.dart';
import 'package:get/get.dart';

class ExerciseController extends GetxController {
  final ExerciseService _exerciseService = ExerciseService();

  RxList<Exercise> exercises = <Exercise>[].obs;
  RxBool isLoading = false.obs;
  RxString selectedBodyPart = 'chest'.obs;
  RxInt page = 0.obs;

  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchExercises();
  }

  Future<void> fetchExercises({bool reset = false}) async {
    if (reset) {
      exercises.clear();
      page.value = 0;
    }

    try {
      isLoading.value = true;

      final fetchedExercises = await _exerciseService.getExercises(
        page: page.value,
        limit: limit,
        bodyPart: selectedBodyPart.value,
      );

      if (fetchedExercises.isNotEmpty) {
        exercises.addAll(fetchedExercises);
        page.value++; // Increment page for the next fetch
      } else {
        Get.snackbar('End of List', 'No more exercises available.');
      }
    } catch (e) {
      print('Error loading exercises: $e');
      Get.snackbar('Error', 'Failed to load exercises: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchExercises(String query) async {
    if (query.isEmpty) {
      fetchExercises(reset: true);
      return;
    }

    try {
      isLoading.value = true;

      final allExercises = await _exerciseService.getExercises(
        page: 0,
        limit: 100, // Fetch a large number of exercises for searching
        bodyPart: selectedBodyPart.value,
      );

      exercises.value = allExercises
          .where((exercise) =>
              exercise.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (exercises.isEmpty) {
        Get.snackbar('No Results', 'No exercises found for "$query".');
      }
    } catch (e) {
      exercises.clear();
      Get.snackbar('Error', 'Failed to search exercises: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
