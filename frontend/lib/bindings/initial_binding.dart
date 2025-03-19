import 'package:frontend/repository/mock/mock_workout_repository.dart';
import 'package:frontend/controller/workout_session_controller.dart';
import 'package:get/get.dart';
import '../repository/workout_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core dependencies
    Get.put<WorkoutRepository>(MockWorkoutRepository(), permanent: true);

    // Controllers
    Get.lazyPut(() => WorkoutSessionController());
  }
}
