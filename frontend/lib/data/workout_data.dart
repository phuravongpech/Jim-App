import 'package:frontend/models/workout.dart';

import '../models/exercise.dart';
import '../models/workout_exercise.dart';
import '../models/workout_log.dart';

final List<Exercise> exercises = [
  Exercise(
      id: '11',
      gifUrl: 'hi',
      bodyPart: 'h',
      target: 'h',
      equipment: 'hi',
      name: 'Barbell Squat',
      instructions: ['i', 'love', 'you']),
  Exercise(
      id: '12',
      gifUrl: 'hi',
      bodyPart: 'h',
      target: 'h',
      equipment: 'hi',
      name: 'Barbell Squat',
      instructions: ['i', 'love', 'you']),
];

final List<Workout> workouts = [
  Workout(
    name: 'Leg Day Intense',
    description: 'Comprehensive lower body strength training',
    date: DateTime.now(),
    isCompleted: false,
    exercises: [
      exercises[0], // Plank
      exercises[1],
    ],
    category: Category.strength,
  ),
  Workout(
    name: 'Upper Body Power',
    description: 'Powerlifting focus on chest and pulling movements',
    date: DateTime.now().subtract(const Duration(days: 2)),
    isCompleted: true,
    exercises: [
      exercises[0], // Plank
    ],
    category: Category.powerlifting,
  ),
  Workout(
    name: 'Core and Stability',
    description: 'Focused core workout for stability and endurance',
    date: DateTime.now().subtract(const Duration(days: 7)),
    isCompleted: false,
    exercises: [
      exercises[0], // Plank
    ],
    category: Category.cardio,
  ),
];

final List<WorkoutExercise> workoutExercises = [
  WorkoutExercise(
    workout: workouts[0],
    exercise: workouts[0].exercises[0], // Barbell Squat
    restTimeSecond: 10,
    set: 3,
  ),
  WorkoutExercise(
    workout: workouts[0],
    exercise: workouts[0].exercises[1], // Deadlift
    restTimeSecond: 180,
    set: 3,
  ),
  WorkoutExercise(
    workout: workouts[0],
    exercise: workouts[0].exercises[2], // Lunges
    restTimeSecond: 90,
    set: 3,
  ),
  WorkoutExercise(
    workout: workouts[1],
    exercise: exercises[0], // Bench Press
    restTimeSecond: 120,
    set: 3,
  ),
  WorkoutExercise(
    workout: workouts[1],
    exercise: workouts[1].exercises[1], // Pull-ups
    restTimeSecond: 90,
    set: 3,
  ),
  WorkoutExercise(
    workout: workouts[1],
    exercise: workouts[1].exercises[2], // Overhead Press
    restTimeSecond: 120,
    set: 3,
  ),
  WorkoutExercise(
    workout: workouts[2],
    exercise: workouts[2].exercises[0], // Plank
    restTimeSecond: 60,
    set: 4,
  ),
  WorkoutExercise(
    workout: workouts[2],
    exercise: workouts[2].exercises[1], // Running
    restTimeSecond: 0, // No rest, continuous activity
    set: 1,
  ),
];

final List<WorkoutLog> workoutLogs = [];

// final List<WorkoutLog> workoutLogs = [
//   // Logs for Barbell Squat (Workout 0, Exercise 0)
//   WorkoutLog(
//     workoutExercise: workoutExercises[0],
//     weight: 20,
//     rep: 10,
//     setNumber: 1,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[0],
//     weight: 22.5,
//     rep: 9,
//     setNumber: 2,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[0],
//     weight: 25,
//     rep: 8,
//     setNumber: 3,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[0],
//     weight: 0,
//     rep: 0,
//     setNumber: 4,
//   ),

//   // Logs for Deadlift (Workout 0, Exercise 1)
//   WorkoutLog(
//     workoutExercise: workoutExercises[1],
//     weight: 20,
//     rep: 10,
//     setNumber: 1,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[1],
//     weight: 22.5,
//     rep: 9,
//     setNumber: 2,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[1],
//     weight: 25,
//     rep: 8,
//     setNumber: 3,
//   ),

//   // Logs for Bench Press (Workout 1, Exercise 0)
//   WorkoutLog(
//     workoutExercise: workoutExercises[2],
//     weight: 20,
//     rep: 10,
//     setNumber: 1,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[2],
//     weight: 22.5,
//     rep: 9,
//     setNumber: 2,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[2],
//     weight: 25,
//     rep: 8,
//     setNumber: 3,
//   ),

//   // Logs for Pull-ups (Workout 1, Exercise 1)
//   WorkoutLog(
//     workoutExercise: workoutExercises[3],
//     weight: 0, // Bodyweight exercise
//     rep: 10,
//     setNumber: 1,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[3],
//     weight: 0,
//     rep: 9,
//     setNumber: 2,
//   ),
//   WorkoutLog(
//     workoutExercise: workoutExercises[3],
//     weight: 0,
//     rep: 8,
//     setNumber: 3,
//   ),
// ];
