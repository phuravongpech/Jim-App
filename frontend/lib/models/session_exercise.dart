class SessionExercise {
  final String exerciseId;
  final String exerciseName;
  final int restTimeSecond;
  final int setCount;

  SessionExercise({
    required this.exerciseId,
    required this.exerciseName,
    required this.restTimeSecond,
    required this.setCount,
  });

  factory SessionExercise.fromJson(Map<String, dynamic> json) {
    return SessionExercise(
      exerciseId: json['exerciseId'],
      exerciseName: json['exerciseName'],
      restTimeSecond: json['restTimeSecond'],
      setCount: json['setCount'],
    );
  }
}
