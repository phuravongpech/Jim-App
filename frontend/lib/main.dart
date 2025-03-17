import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/repository/mock/mock_exercise_repository.dart';
import 'package:frontend/repository/mock/mock_workout_repository.dart';
import 'package:frontend/repository/real/real_workout_repository.dart';
import 'package:frontend/routes/route_manager.dart';
import 'package:frontend/services/exercise_service.dart';
import 'package:frontend/services/workout_service.dart';
import 'package:frontend/theme/theme.dart';
import 'package:get/get.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }

  // Initialize the services
  ExerciseService.initialize(MockExerciseRepository());
  WorkoutService.initialize(RealWorkoutRepository());

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: appTheme,
    initialRoute: routes[0].name,
    getPages: routes,
  ));
}
