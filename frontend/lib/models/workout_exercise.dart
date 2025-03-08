class WorkoutExercise {
  final String exerciseId;
  late final int set;
  late final int restTimeSecond;

  WorkoutExercise({
    required this.exerciseId,
    this.set = 4,
    this.restTimeSecond = 90,
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

  @override
  String toString() {
    return 'WorkoutExercise{\n  exerciseId: $exerciseId,\n  set: $set,\n  restTimeSecond: $restTimeSecond\n}';
  }
}
