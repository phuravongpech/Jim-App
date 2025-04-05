import 'package:frontend/controller/workout_session_controller.dart';
import 'package:frontend/repository/real/real_workout_repository.dart';
import 'package:get/get.dart';
import '../repository/workout_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core dependencies
    Get.put<WorkoutRepository>(RealWorkoutRepository(), permanent: true);

    // Controllers
    Get.lazyPut(() => WorkoutSessionController());
  }
}
