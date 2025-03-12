import 'package:frontend/models/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> getExercises({
    required int page,
    required int limit,
  });

  searchExercises({required String query}) {}
}
