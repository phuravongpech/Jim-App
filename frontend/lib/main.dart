import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/bindings/initial_binding.dart';
import 'package:frontend/routes/route_manager.dart';
import 'package:frontend/services/exercise_service.dart';
import 'package:frontend/services/workout_service.dart';
import 'package:frontend/theme/theme.dart';
import 'package:get/get.dart';

import 'repository/real/real_exercise_repository.dart';
import 'repository/real/real_workout_repository.dart';
import 'services/workout_session_service.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }

  ExerciseService.initialize(RealExerciseRepository());
  WorkoutService.initialize(RealWorkoutRepository());
  WorkoutSessionService.instance.initialize(RealWorkoutRepository());
  // Initialize the controllers

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Jim App',
    initialBinding: InitialBinding(),
    theme: appTheme,
    initialRoute: routes[0].name,
    getPages: routes,
  ));
}
