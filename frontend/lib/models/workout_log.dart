import '../utils/utils.dart';
import 'workout_exercise.dart';

class WorkoutLog {
  final String id; // Unique identifier for the workout log
  final WorkoutExercise workoutExercise;
  late double? weight;
  late int? rep;
  final int setNumber;

  WorkoutLog({
    String? id, // Optional parameter
    required this.workoutExercise,
    this.weight,
    this.rep,
    required this.setNumber,
  }) : id = id ?? Utils.generateUuid(); // Generate a new UUID if not provided

  @override
  String toString() {
    return 'WorkoutLog{\n'
        '  workoutExercise: ${workoutExercise.exercise.name},\n'
        '  weight: $weight,\n'
        '  rep: $rep,\n'
        '  setNumber: $setNumber\n'
        '}';
  }
}
