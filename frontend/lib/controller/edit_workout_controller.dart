import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/exercise.dart';
import '../models/workout_exercise.dart';
import '../services/workout_service.dart';
import 'edit_exercise_controller.dart';
import 'select_exercise_controller.dart';
import 'workout_controller.dart';

class EditWorkoutController extends GetxController {
  late final String workoutId;
  var xWorkoutTitle = ''.obs;
  var xWorkoutDescription = ''.obs;
  var xSelectedExercises = <Exercise>[].obs;
  var workoutExercises = <WorkoutExercise>[].obs;

  final log = Logger();

  EditWorkoutController({required this.workoutId}) {
    fetchWorkoutDetail(workoutId);
  }

  final WorkoutService service = WorkoutService.instance;

  // Define editExerciseController as a dependency
  final editExerciseController = Get.put<EditExerciseController>(
    EditExerciseController(),
  );

  // Fetch workout details and populate fields
  void fetchWorkoutDetail(String id) async {
    try {
      final workoutDetail = await service.getWorkoutWithExercisesFor(id);
      xWorkoutTitle.value = workoutDetail.name;
      xWorkoutDescription.value = workoutDetail.description;

      // Convert CustomWorkoutExercise to Exercise
      xSelectedExercises.assignAll(workoutDetail.workoutExercises
          .map((e) => Exercise.fromCustomWorkoutExercise(e)));

      // Convert CustomWorkoutExercise to WorkoutExercise
      workoutExercises
          .assignAll(workoutDetail.workoutExercises.map((e) => WorkoutExercise(
                exerciseId: e.exerciseId,
                setCount: e.setCount,
                restTimeSecond: e.restTimeSecond,
                // Add any other necessary fields
              )));
      // Initialize edit exercise controller
      editExerciseController.initializeExercises(workoutExercises.toList());
    } catch (e) {
      log.e('Error fetching workout details: $e');
    }
  }

  Future<void> refreshWorkoutList() async {
    try {
      final workoutController = Get.find<WorkoutController>();
      workoutController.fetchWorkouts();
    } catch (e) {
      log.e('Error refreshing workout list: $e');
    }
  }

  // Update workout data
  Future<void> updateWorkout(String workoutId) async {
    try {
      await service.updateWorkout(
        workoutId: workoutId,
        name: xWorkoutTitle.value,
        description: xWorkoutDescription.value,
        exercises: xSelectedExercises.toList(),
        workoutExercises: workoutExercises.toList(),
      );

      // Refresh the workout list
      await refreshWorkoutList();

      log.i('Workout updated successfully!');
      Get.back(result: true);
    } catch (e) {
      log.e('Error updating workout: $e');
    }
  }

  void updateExercises(List<WorkoutExercise> updatedExercises) {
    workoutExercises.assignAll(updatedExercises);

    // Get the SelectExerciseController instance
    final selectExerciseController = Get.find<SelectExerciseController>();

    // Update xSelectedExercises with complete exercise data
    xSelectedExercises.assignAll(updatedExercises.map((workoutExercise) {
      // Find the full exercise details from selectExerciseController
      final fullExercise =
          selectExerciseController.getExerciseById(workoutExercise.exerciseId);

      // If not found, create a basic exercise with the ID
      return fullExercise ??
          Exercise(
            id: workoutExercise.exerciseId,
            name: 'Unknown Exercise',
            gifUrl: '',
            bodyPart: '',
            equipment: '',
            target: '',
            instructions: [],
          );
    }).toList());
  }
}
