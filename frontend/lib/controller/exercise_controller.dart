import 'package:frontend/models/exercise.dart';
import 'package:frontend/services/exercise_service.dart';
import 'package:frontend/services/mock_exercise_service.dart'; // Import Mock service
import 'package:get/get.dart';

import '../repository/exercise_repository.dart';

class ExerciseController extends GetxController {
  // Flag used for swicthing between mock service and real service
  bool useMock = true;

  late final ExerciseRepository _exerciseService;

  RxList<Exercise> exercises = <Exercise>[].obs;
  RxBool isLoading = false.obs;
  RxString selectedBodyPart = 'chest'.obs;
  RxInt page = 0.obs;

  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    _exerciseService = useMock ? MockExerciseService() : ExerciseService();
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

      final allExercises = await _exerciseService.searchExercises(query: query);

      exercises.value = allExercises;

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
