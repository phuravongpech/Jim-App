import 'package:frontend/models/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> getExercises();
}
