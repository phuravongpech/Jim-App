import 'package:frontend/models/exercise.dart';
import 'package:frontend/services/exercise_service.dart';
import 'package:get/get.dart';

class ExerciseController extends GetxController {
  final ExerciseService _exerciseService = ExerciseService();
  RxList<Exercise> exercises = <Exercise>[].obs;
  RxBool isLoading = true.obs;
  RxString selectedBodyPart = 'chest'.obs;
  RxInt page = 0.obs;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    try {
      isLoading.value = true;
      final fetchedExercises = await _exerciseService.getExercises(
        page: page.value,
        limit: limit,
        bodyPart: selectedBodyPart.value,
      );

      exercises.value = fetchedExercises;
    } catch (e) {
      print('Error loading exercises: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchExercises(String query) async {
    try {
      isLoading.value = true;
      final searchedExercises =
          await _exerciseService.searchExercises(query: query);

      if (searchedExercises.isNotEmpty) {
        exercises.value = searchedExercises
            .where((exercise) =>
                exercise.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        exercises.clear();
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
