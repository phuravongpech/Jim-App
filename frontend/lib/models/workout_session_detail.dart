import 'package:frontend/models/logged_exercise.dart';

class WorkoutSessionDetail {
  final int id;
  final DateTime startWorkout;
  final DateTime endWorkout;
  final String workoutName;
  final String workoutDescription;
  final List<LoggedExercise> loggedExercises;

  WorkoutSessionDetail({
    required this.id,
    required this.startWorkout,
    required this.endWorkout,
    required this.workoutName,
    required this.workoutDescription,
    required this.loggedExercises,
  });

  factory WorkoutSessionDetail.fromJson(Map<String, dynamic> json) {
    return WorkoutSessionDetail(
      id: json['id'],
      startWorkout: DateTime.parse(json['startWorkout']),
      endWorkout: DateTime.parse(json['endWorkout']),
      workoutName: json['workoutName'],
      workoutDescription: json['workoutDescription'] ?? '',
      loggedExercises: (json['loggedSets'] as List)
          .map((e) => LoggedExercise.fromJson(e))
          .toList(),
    );
  }

  String get duration {
    final diff = endWorkout.difference(startWorkout);
    return '${diff.inMinutes} mins';
  }
}