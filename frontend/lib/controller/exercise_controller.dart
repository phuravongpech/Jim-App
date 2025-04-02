import 'package:frontend/models/exercise.dart';
import 'package:frontend/services/exercise_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ExerciseController extends GetxController {
  RxList<Exercise> exercises = <Exercise>[].obs;
  RxBool isLoading = false.obs;
  RxString selectedBodyPart = 'chest'.obs;
  RxInt page = 0.obs;
  final log = Logger();

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

      final fetchedExercises = await ExerciseService.instance.fetchExercises(
        page: page.value,
        limit: limit,
      );

      if (fetchedExercises.isNotEmpty) {
        exercises.addAll(fetchedExercises);
        page.value++; // Increment page for the next fetch
      } else {
        log.i('No more exercises available.');
      }
    } catch (e) {
      log.e('Error fetching exercises: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchExercises(String query, {bool reset = false}) async {
    if (reset) {
      exercises.clear();
      page.value = 0;
    }

    try {
      isLoading.value = true;

      final searchedExercises = await ExerciseService.instance.searchExercises(
        query: query,
        page: page.value,
        limit: limit,
      );

      if (searchedExercises.isNotEmpty) {
        exercises.addAll(searchedExercises);
        page.value++; // Increment page for the next fetch
      } else if (reset) {
        log.i('No exercises found for "$query".');
      }
    } catch (e) {
      log.e('Error searching exercises: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
