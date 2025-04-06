import 'package:frontend/models/workout_with_exercise.dart';

import '../utils/uuid_utils.dart';
import 'workout_exercise.dart';

class LoggedSet {
  final String id; // Unique identifier for the workout log
  final int? workoutExerciseId;
  final WorkoutExercise? workoutExercise;
  final CustomWorkoutExercise? customWorkoutExercise;
  final double? weight;
  final int? rep;
  final int setNumber;

  LoggedSet({
    String? id,
    this.workoutExerciseId,
    this.workoutExercise,
    this.customWorkoutExercise,
    this.weight,
    this.rep,
    required this.setNumber,
  }) : id = id ??
            UuidUtils.generateUuid(); // Generate a new UUID if not provided

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workoutExerciseId': workoutExerciseId,
      'weight': weight,
      'rep': rep,
      'setNumber': setNumber,
    };
  }

  factory LoggedSet.fromJson(Map<String, dynamic> json) {
    return LoggedSet(
      id: json['id'],
      workoutExerciseId: json['workoutExerciseId'],
      weight: json['weight'].toDouble(),
      rep: json['rep'],
      setNumber: json['setNumber'],
    );
  }

  static List<LoggedSet> listFromJson(List<dynamic> json) {
    return json.map((x) => LoggedSet.fromJson(x)).toList();
  }

  static List<Map<String, dynamic>> listToJson(List<LoggedSet> sets) {
    return sets.map((x) => x.toJson()).toList();
  }

  @override
  String toString() {
    return 'LoggedSet{id: $id, workoutExerciseId: $workoutExerciseId, weight: $weight, rep: $rep, setNumber: $setNumber}';
  }
}
