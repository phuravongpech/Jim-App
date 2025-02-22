import 'package:frontend/screens/exercise/exercise_detail_screen.dart';
import 'package:frontend/screens/exercise/exercise_screen.dart';
import 'package:frontend/screens/profile/profile_screen.dart';
import 'package:frontend/screens/progress/progress_screen.dart';
import 'package:frontend/screens/workout/create_workout_screen.dart';
import 'package:frontend/screens/workout/workout_screen.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: '/workout', page: () => WorkoutScreen()),
  GetPage(name: '/create-workout', page: () => CreateWorkoutScreen()),
  GetPage(name: '/exercise', page: () => ExerciseScreen()),
  GetPage(
      name: '/exercise-detail',
      page: () => ExerciseDetail(exercise: Get.arguments)),
  GetPage(name: '/progress', page: () => ProgressScreen()),
  GetPage(name: '/profile', page: () => ProfileScreen()),
];
