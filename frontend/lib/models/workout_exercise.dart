class WorkoutExercise {
  final String exerciseId;
  int set;
  int restTimeSecond;

  WorkoutExercise({
    required this.exerciseId,
    required this.set,
    required this.restTimeSecond,
  });

  /// Create a new [WorkoutExercise] from a JSON object
  WorkoutExercise copyWith({
    String? exerciseId,
    int? set,
    int? restTimeSecond,
  }) {
    return WorkoutExercise(
      exerciseId: exerciseId ?? this.exerciseId,
      set: set ?? this.set,
      restTimeSecond: restTimeSecond ?? this.restTimeSecond,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'set': set,
      'restTimeSecond': restTimeSecond,
    };
  }

  @override
  String toString() {
    return 'WorkoutExercise{\n  exerciseId: $exerciseId,\n  set: $set,\n  restTimeSecond: $restTimeSecond\n}';
  }
}
