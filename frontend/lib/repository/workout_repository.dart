import 'package:frontend/models/exercise.dart';
import 'package:frontend/models/logged_set.dart';
import 'package:frontend/models/workout_exercise.dart';

import '../models/workout.dart';
import '../models/workout_with_exercise.dart';

abstract class WorkoutRepository {
  Future<void> saveWorkouts({
    required String name,
    required String description,
    required List<Exercise> exercises,
    required List<WorkoutExercise> workoutExercises,
  });

  Future<List<WorkoutExercise>> getWorkoutExercises(String workoutId);

  Future<List<Workout>> getWorkoutWithExercises();

  Future<WorkoutWithExercise> getWorkoutWithExercisesFor(String workoutId);

  Future<void> deleteWorkout(String workoutId);

  Future<void> updateWorkout({
    required String workoutId,
    required String name,
    required String description,
    required List<Exercise> exercises,
    required List<WorkoutExercise> workoutExercises,
  });

  //deal with the logged sets

  Future<void> saveLoggedSets({
    required String workoutId,
    required DateTime startWorkout,
    required DateTime endWorkout,
    required List<LoggedSet> loggedSets,
  });
}
