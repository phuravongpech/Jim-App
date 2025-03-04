class WorkoutExercise {
  final String exerciseId;
  final int set;
  final int restTimeSecond;

  WorkoutExercise({
    required this.exerciseId,
    required this.set,
    required this.restTimeSecond,
  });

  @override
  String toString() {
    return 'WorkoutExercise{\n  exerciseId: $exerciseId,\n  set: $set,\n  restTimeSecond: $restTimeSecond\n}';
  }
}
