import '../utils/uuid_utils.dart';
import 'workout_exercise.dart';

class WorkoutLog {
  final String id; // Unique identifier for the workout log
  final WorkoutExercise workoutExercise;
  late double? weight;
  late int? rep;
  final int setNumber;

  WorkoutLog({
    String? id,
    required this.workoutExercise,
    this.weight,
    this.rep,
    required this.setNumber,
  }) : id = id ??
            UuidUtils.generateUuid(); // Generate a new UUID if not provided

  @override
  String toString() {
    return 'WorkoutLog{\n  workoutExercise: $workoutExercise,\n  weight: $weight,\n  rep: $rep,\n  setNumber: $setNumber\n}';
  }
}
