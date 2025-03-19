import 'package:frontend/screens/exercise/exercise_detail_screen.dart';
import 'package:frontend/screens/exercise/exercise_screen.dart';
import 'package:frontend/screens/workout/create_workout_screen.dart';
import 'package:frontend/screens/workout/edit_exercise_screen.dart';
import 'package:frontend/screens/workout/workout_detail_screen.dart';
import 'package:frontend/screens/workout/workout_screen.dart';
import 'package:frontend/screens/workout_session/set_log_screen.dart';
import 'package:frontend/screens/workout_session/timer_screen.dart';
import 'package:get/get.dart';

import '../screens/workout/select_exercise_screen.dart';

final routes = [
  GetPage(name: '/workout', page: () => WorkoutScreen()),
  GetPage(name: '/create-workout', page: () => CreateWorkoutScreen()),
  GetPage(name: '/exercise', page: () => ExerciseScreen()),
  GetPage(
    name: '/exercise-detail',
    page: () => ExerciseDetail(exercise: Get.arguments),
  ),
  // GetPage(name: '/progress', page: () => ProgressScreen()),
  GetPage(name: '/progress', page: () => TimerScreen()),
  // GetPage(name: '/progress', page: () => SessionScreen()),

  GetPage(name: '/profile', page: () => SetLogScreen()),
  GetPage(
    name: '/select-exercises',
    page: () => SelectExerciseScreen(),
  ),
  GetPage(
    name: '/edit-exercises',
    page: () => EditExerciseScreen(),
  ),
  GetPage(
    name: '/workout-detail',
    page: () => WorkoutDetailScreen(),
    // No need to specify return type in the route definition
  ),
];
