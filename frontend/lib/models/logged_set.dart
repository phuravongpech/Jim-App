import '../utils/uuid_utils.dart';
import 'workout_exercise.dart';

class LoggedSet {
  final String id; // Unique identifier for the workout log
  late String? workoutExerciseId;
  final WorkoutExercise? workoutExercise;
  late double? weight;
  late int? rep;
  final int setNumber;

  LoggedSet({
    String? id,
    this.workoutExerciseId,
    this.workoutExercise,
    this.weight,
    this.rep,
    required this.setNumber,
  }) : id = id ??
            UuidUtils.generateUuid(); // Generate a new UUID if not provided

  @override
  String toString() {
    return 'LoggedSet {{\n  workoutExercise: $workoutExercise,\n  weight: $weight,\n  rep: $rep,\n  setNumber: $setNumber\n}';
  }
}
