import 'package:frontend/models/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> fetchExercises({
    required int page,
    required int limit,
  });

  Future<List<Exercise>> searchExercises({
    required int page,
    required int limit,
    required String query,
  });
}
