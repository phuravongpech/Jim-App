import 'package:frontend/models/logged_set.dart';

class LoggedExercise {
  final String exerciseName;
  final int restTime;
  final List<LoggedSet> sets;

  LoggedExercise({
    required this.exerciseName,
    required this.restTime,
    required this.sets,
  });

  factory LoggedExercise.fromJson(Map<String, dynamic> json) {
    return LoggedExercise(
      exerciseName: json['exerciseName'],
      restTime: json['restTime'],
      sets: (json['sets'] as List)
          .map((e) => LoggedSet.fromJson(e))
          .toList(),
    );
  }
}