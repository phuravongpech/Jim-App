// import 'package:get/get.dart';

// import '../services/workout_service.dart';

// class WorkoutDetailController extends GetxController {
//   var xWorkoutTitle = ''.obs;
//   var xWorkoutDescription = ''.obs;
//   var xWorkoutExercises = [].obs;

//   final service = WorkoutService.instance;

//   @override
//   void onInit() {
//     super.onInit();
//     String? workoutId = Get.arguments;
//     if (workoutId != null) {
//       fetchWorkoutDetail(workoutId);
//     }
//   }

//   // Fetch workout details by ID
//   void fetchWorkoutDetail(String id) async {
//     try {
//       final fetchedWorkout =
//           await WorkoutService.instance.getWorkoutWithExercisesFor(id);
//       xWorkoutTitle.value = fetchedWorkout.name;
//       xWorkoutDescription.value = fetchedWorkout.description;
//       xWorkoutExercises.addAll(fetchedWorkout.workoutExercises);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load workout details: $e');
//     }
//   }
// }
