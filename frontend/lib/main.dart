import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/common/colors.dart';
import 'package:frontend/screens/exercise/exercise_screen.dart';
import 'package:get/get.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    color: AppColor.primaryBackground,
    home: ExerciseScreen(),
  ));
}
