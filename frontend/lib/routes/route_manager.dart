import 'package:frontend/screens/exercise/exercise_detail_screen.dart';
import 'package:frontend/screens/exercise/exercise_screen.dart';
import 'package:frontend/screens/workout/create_workout_screen.dart';
import 'package:frontend/screens/workout/edit_exercise_screen.dart';
import 'package:frontend/screens/workout/workout_detail_screen.dart';
import 'package:frontend/screens/workout/workout_screen.dart';
import 'package:frontend/screens/workout_history/workout_history_screen.dart';
import 'package:frontend/screens/workout_session/set_log_screen.dart';
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
  GetPage(name: '/history', page: () => WorkoutHistoryScreen()),
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
  GetPage(name: '/edit-workout', page: () => EditExerciseScreen()),
];
