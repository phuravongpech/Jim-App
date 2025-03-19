import 'package:frontend/repository/workout_repository.dart';

import '../models/exercise.dart';
import '../models/workout.dart';
import '../models/workout_exercise.dart';

class WorkoutService {
  static WorkoutService? _instance;

  final WorkoutRepository repository;

  WorkoutService._internal(this.repository);

  ///
  /// Initialize
  ///
  static void initialize(WorkoutRepository repository) {
    if (_instance == null) {
      _instance = WorkoutService._internal(repository);
    } else {
      throw Exception("ExerciseService is already initialized");
    }
  }

  ///
  /// Singleton accessor
  ///
  static WorkoutService get instance {
    if (_instance == null) {
      throw Exception(
          "ExerciseService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  ///
  ///
  ///

  Future<List<Workout>> fetchWorkouts() {
    return repository.fetchWorkouts();
  }

  Future<Workout> getWorkoutById(String id) {
    return repository.getWorkoutById(id);
  }

  Future<void> saveWorkout({
    required String name,
    required String description,
    required List<Exercise> exercises,
    required List<WorkoutExercise> workoutExercises,
  }) {
    return repository.saveWorkouts(
        name: name,
        description: description,
        exercises: exercises,
        workoutExercises: workoutExercises);
  }

  Future<List<WorkoutExercise>> getWorkoutExercises(String workoutId) {
    return repository.getWorkoutExercises(workoutId);
  }
}
