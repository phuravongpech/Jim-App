import 'package:uuid/uuid.dart';

import '../models/workout.dart';
import '../models/workout_exercise.dart';

class Utils {
  static final Uuid _uuid = Uuid();

  static String generateUuid() {
    return _uuid.v4();
  }
}

List<WorkoutExercise> getExercisesFromWorkout(
    List<WorkoutExercise> workoutExercise, Workout workout) {
  return workoutExercise.where((we) => we.workout.id == workout.id).toList();
}
