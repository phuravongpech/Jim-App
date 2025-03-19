import 'package:frontend/models/exercise.dart';
import 'package:frontend/models/workout.dart';
import 'package:frontend/utils/uuid_utils.dart';

class WorkoutExercise {
  final String globalId;
  final String exerciseId;
  final Exercise? exercise;
  // The ID of the workout that this exercise belongs to
  //when the workout is created, the workoutId is the same as the workout's ID
  //but since its uuid generated, it cannot be accessed from the workout object until the
  //workout is saved first
  //so when the workout is saved, the workoutId is updated to the workout's ID
  //but now sadly have to put nullable sin
  late String? workoutId;
  final Workout? workout;
  int setCount;
  int restTimeSecond;

  WorkoutExercise({
    String? globalId,
    required this.exerciseId,
    this.exercise,
    this.workoutId,
    this.workout,
    required this.setCount,
    required this.restTimeSecond,
  }) : globalId = UuidUtils.generateUuid();

  Map<String, dynamic> toJson() {
    return {
      'globalId': globalId,
      'workoutId': workoutId,
      'exerciseId': exerciseId,
      'setCount': setCount,
      'restTimeSecond': restTimeSecond,
    };
  }

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) {
    return WorkoutExercise(
      globalId: json['globalId'],
      workoutId: json['workoutId'],
      exerciseId: json['exerciseId'],
      setCount: json['setCount'],
      restTimeSecond: json['restTimeSecond'],
    );
  }

  /// Create a new [WorkoutExercise] from a JSON object
  WorkoutExercise copyWith({
    String? globalId,
    String? workoutId,
    String? exerciseId,
    int? setCount,
    int? restTimeSecond,
  }) {
    return WorkoutExercise(
      globalId: globalId ?? this.globalId,
      workoutId: workoutId ?? this.workoutId,
      exerciseId: exerciseId ?? this.exerciseId,
      exercise: exercise,
      setCount: setCount ?? this.setCount,
      restTimeSecond: restTimeSecond ?? this.restTimeSecond,
    );
  }

  @override
  String toString() {
    return 'WorkoutExercise{\n  globalId: $globalId,\n  exerciseId: $exerciseId,\n  set: $setCount,\n  restTimeSecond: $restTimeSecond\n}';
  }
}
