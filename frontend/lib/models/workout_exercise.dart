import '../utils/utils.dart';
import 'exercise.dart';
import 'workout.dart';

//link workout to exercise
//workout 1 ex1 3 sets, w1 ex2 4 sets...
class WorkoutExercise {
  final String id; // Unique identifier for the workout exercise
  final Workout workout;
  final Exercise exercise;
  final int set;
  final int restTimeSecond;

  WorkoutExercise({
    String? id, // Optional parameter
    required this.workout,
    required this.exercise,
    required this.set,
    required this.restTimeSecond,
  }) : id = id ?? Utils.generateUuid(); // Generate a new UUID if not provided

  @override
  String toString() {
    return 'WorkoutExercise{\n  workout: ${workout.name},\n  exercise: ${exercise.name},\n  set: $set,\n  restTimeSecond: $restTimeSecond\n}';
  }
}
