import 'package:frontend/models/exercise.dart';
import 'package:frontend/models/workout_exercise.dart';

import '../models/workout.dart';

abstract class WorkoutRepository {
  Future<void> saveWorkouts({
    required String name,
    required String description,
    required List<Exercise> exercises,
    required List<WorkoutExercise> workoutExercises,
  });

  Future<List<WorkoutExercise>> getWorkoutExercises(String workoutId);

  Future<List<Workout>> getWorkoutWithExercises();

  Future<Workout> getWorkoutWithExercisesFor(String workoutId);
}
