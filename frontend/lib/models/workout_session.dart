import 'package:frontend/models/session_exercise.dart';
import 'package:intl/intl.dart';

class WorkoutSession {
  final int id;
  final DateTime startWorkout;
  final DateTime endWorkout;
  final String workoutName;
  final String workoutDescription;
  final List<SessionExercise> exercises;

  WorkoutSession({
    required this.id,
    required this.startWorkout,
    required this.endWorkout,
    required this.workoutName,
    required this.workoutDescription,
    required this.exercises,
  });

  factory WorkoutSession.fromJson(Map<String, dynamic> json) {
    return WorkoutSession(
      id: json['id'],
      startWorkout: DateTime.parse(json['startWorkout']),
      endWorkout: DateTime.parse(json['endWorkout']),
      workoutName: json['workoutName'],
      workoutDescription: json['workoutDescription'] ?? '',
      exercises: (json['workoutExercises'] as List)
          .map((e) => SessionExercise.fromJson(e))
          .toList(),
    );
  }

  String get formattedDate => DateFormat('MMM dd, yyyy').format(startWorkout);
  String get formattedTime => DateFormat('HH:mm').format(startWorkout);
  String get duration {
    final diff = endWorkout.difference(startWorkout);
    return '${diff.inMinutes} mins';
  }
}



// workout_session_detail.dart


