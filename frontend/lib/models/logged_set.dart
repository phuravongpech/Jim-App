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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workoutExerciseId': workoutExercise?.exerciseId,
      'weight': weight,
      'rep': rep,
      'setNumber': setNumber,
    };
  }

  factory LoggedSet.fromJson(Map<String, dynamic> json) {
    return LoggedSet(
      id: json['id'],
      workoutExerciseId: json['workoutExerciseId'],
      weight: json['weight']?.toDouble(),
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
    return 'LoggedSet {{\n  workoutExercise: $workoutExercise,\n  weight: $weight,\n  rep: $rep,\n  setNumber: $setNumber\n}';
  }
}
