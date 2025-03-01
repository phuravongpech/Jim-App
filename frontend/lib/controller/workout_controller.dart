import 'package:get/get.dart';

class WorkoutController extends GetxController {
  var workoutTitle = ''.obs;
  var workoutDescription = ''.obs;

  void saveWorkout() {
    if (workoutTitle.isEmpty) {
      Get.snackbar('Error', 'Workout Title is required!');
      return;
    }
    print('Workout Title: ${workoutTitle.value}');
    print('Description: ${workoutDescription.value}');
  }
}
