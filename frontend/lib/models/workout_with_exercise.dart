import 'package:frontend/models/exercise.dart';

class WorkoutWithExercise {
  final int id;
  final String name;
  final String description;
  final List<CustomWorkoutExercise> workoutExercises;

  WorkoutWithExercise({
    required this.id,
    required this.name,
    required this.description,
    required this.workoutExercises,
  });

  factory WorkoutWithExercise.fromJson(Map<String, dynamic> json) {
    return WorkoutWithExercise(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      workoutExercises: (json['workoutExercises'] as List)
          .map((exercise) => CustomWorkoutExercise.fromJson(exercise))
          .toList(),
    );
  }
}

class CustomWorkoutExercise {
  final int id;
  final int workoutId;
  final String exerciseId;
  final int restTimeSecond;
  final int setCount;
  final Exercise exercise;

  CustomWorkoutExercise({
    required this.id,
    required this.workoutId,
    required this.exerciseId,
    required this.restTimeSecond,
    required this.setCount,
    required this.exercise,
  });

  factory CustomWorkoutExercise.fromJson(Map<String, dynamic> json) {
    return CustomWorkoutExercise(
      id: json['id'],
      workoutId: json['workoutId'],
      exerciseId: json['exerciseId'],
      restTimeSecond: json['restTimeSecond'],
      setCount: json['setCount'],
      exercise: Exercise.fromJson(json['exercise']),
    );
  }
}
