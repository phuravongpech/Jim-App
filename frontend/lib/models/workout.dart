// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'exercise.dart';
import 'workout_exercise.dart';
import 'workout_log.dart';

enum Category { strength, powerlifting, cardio }

extension CategoryExtension on Category {
  IconData get icon {
    switch (this) {
      case Category.strength:
        return Icons.fitness_center;
      case Category.powerlifting:
        return Icons.sports_mma;
      case Category.cardio:
        return Icons.directions_run;
      default:
        return Icons.help;
    }
  }

  String get name {
    switch (this) {
      case Category.strength:
        return 'Strength';
      case Category.powerlifting:
        return 'Powerlifting';
      case Category.cardio:
        return 'Cardio';
      default:
        return 'Unknown';
    }
  }
}

class Workout {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  bool isCompleted;
  final List<Exercise> exercises;
  final Category category; // Enum for workout type

  Workout({
    String? id,
    required this.name,
    required this.description,
    required this.exercises,
    required this.date,
    required this.category, // Assign a category
    this.isCompleted = false,
  }) : id = id ?? Utils.generateUuid();

  @override
  String toString() {
    return 'Workout{\n'
        '  name: $name,\n'
        '  description: $description,\n'
        '  date: $date,\n'
        '  isCompleted: $isCompleted,\n'
        '  exercises: $exercises,\n'
        '  category: $category\n'
        '}';
  }

  List<WorkoutExercise> getExercisesFromWorkout(
      List<WorkoutExercise> workoutExercise) {
    return workoutExercise.where((we) => we.workout.id == id).toList();
  }

  List<WorkoutLog> getWorkoutLogFromWorkoutExercise(
      List<WorkoutLog> workoutLogs, List<WorkoutExercise> workoutExercises) {
    //create a datatype set to store workoutexercise id
    Set<String> workoutExerciseIds =
        workoutExercises.map((we) => we.id).toSet();

    //filter it
    var list = workoutLogs
        .where((workoutLog) =>
            workoutExerciseIds.contains(workoutLog.workoutExercise.id))
        .toList();

    return list;
  }
}

//w1 ex1 set1 30reps x 30kg weight 120sec rest

// List<Workout> workouts = [
//   workout,
// // workout2
// ];

// Workout workout = Workout(
//     name: 'leg',
//     description: 'leg bitchhhhhh',
//     date: DateTime.now(),
//     isCompleted: false,
//     exercises: [
//       Exercise(
//           name: 'Leg Press',
//           description: 'leg press',
//           category: Category.strength),
//       Exercise(
//           name: 'bench Press',
//           description: 'bench press',
//           category: Category.strength),
//     ]);
// Workout workout2 = Workout(
//     name: 'chest',
//     description: 'chest bitchhhhhh',
//     date: DateTime.utc(2024, 10, 17),
//     isCompleted: false,
//     exercises: [
//       Exercise(
//           name: 'Leg Press',
//           description: 'leg press',
//           category: Category.strength),
//       Exercise(
//           name: 'bench Press',
//           description: 'bench press',
//           category: Category.strength),
//     ]);

// WorkoutExercise workoutExercise =
//     WorkoutExercise(workout: workout, exercise: workout.exercises[1], set: 5);

// List<WorkoutLog> workoutLogs = [
//   WorkoutLog(
//       workoutExercise: workoutExercise,
//       weight: 20,
//       rep: 12,
//       setNumber: 1,
//       restTimeSecond: 120),
//   WorkoutLog(
//       workoutExercise: workoutExercise,
//       weight: 20,
//       rep: 11,
//       setNumber: 2,
//       restTimeSecond: 120),
//   WorkoutLog(
//       workoutExercise: workoutExercise,
//       weight: 20,
//       rep: 10,
//       setNumber: 3,
//       restTimeSecond: 120),
// ];
