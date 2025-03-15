import 'package:frontend/models/exercise.dart';
import 'package:frontend/repository/exercise_repository.dart';

class ExerciseService {
  static ExerciseService? _instance;

  final ExerciseRepository repository;

  ExerciseService._internal(this.repository);

  ///
  /// Initialize
  ///
  static void initialize(ExerciseRepository repository) {
    if (_instance == null) {
      _instance = ExerciseService._internal(repository);
    } else {
      throw Exception("ExerciseService is already initialized");
    }
  }

  ///
  /// Singleton accessor
  ///
  static ExerciseService get instance {
    if (_instance == null) {
      throw Exception(
          "ExerciseService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  ///
  ///
  ///

  Future<List<Exercise>> fetchExercises(
      {required int page, required int limit}) {
    return repository.fetchExercises(page: page, limit: limit);
  }

  Future<List<Exercise>> searchExercises({
    required int page,
    required int limit,
    required String query,
  }) {
    return repository.searchExercises(page: page, limit: limit, query: query);
  }
}
