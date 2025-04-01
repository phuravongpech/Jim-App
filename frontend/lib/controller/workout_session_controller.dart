import 'package:flutter/material.dart';
import 'package:frontend/screens/workout_session/workout_summary_screen.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../services/workout_session_service.dart';
import '../screens/workout_session/timer_screen.dart';
import '../screens/workout_session/set_log_screen.dart';

class WorkoutSessionController extends GetxController {
  final service = WorkoutSessionService.instance;
  final log = Logger();

  void logSetAndNavigate(int reps, double weight) {
    service.logSet(reps, weight);
    // Always go to TimerScreen after logging a set.
    Get.to(() => TimerScreen());
  }

  void handleRestComplete() {
    if (service.hasMoreSets) {
      service.moveToNextSet();
      Get.to(() => SetLogScreen());
    } else if (service.hasMoreExercises) {
      service.moveToNextExercise();
      Get.to(() => SetLogScreen());
    } else {
      service.endWorkoutSession();
      Get.offAll(() => WorkoutSummaryScreen());
    }
  }

  void finishWorkout() {
    service.endWorkoutSession();
    Get.offAll(() => WorkoutSummaryScreen());
  }

  void confirmExit() {
    Get.dialog(
      AlertDialog(
        title: Text('Exit Workout?'),
        content: Text('You will lose all current workout progress.'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text(
              'Exit',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              service.endWorkoutSession(); // Clear logged sets
              service.clearSessionData(save: false); // Clear logged sets
              Get.offAllNamed('/workout'); // Adjust route as needed
            },
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    if (service.isWorkoutActive.value) {
      service.endWorkoutSession();
    }
    super.onClose();
  }
}
