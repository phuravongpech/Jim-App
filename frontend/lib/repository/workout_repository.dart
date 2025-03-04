import 'package:frontend/models/exercise.dart';
import 'package:frontend/models/workout_exercise.dart';

import '../models/workout.dart';

abstract class WorkoutRepository {
  Future<List<Workout>> getWorkouts();

  Future<void> saveWorkouts({
    required String name,
    required String description,
    required List<Exercise> exercises,
    required List<WorkoutExercise> workoutExercises,
  });
}
