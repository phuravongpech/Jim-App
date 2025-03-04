import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/common/theme.dart';
import 'package:frontend/routes/route_manager.dart';
import 'package:frontend/screens/workout/workout_screen.dart';
import 'package:get/get.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Poppins',
    ),
    initialRoute: '/',
    getPages: routes,
    color: AppColor.primaryBackground,
    home: WorkoutScreen(),
  ));
}
