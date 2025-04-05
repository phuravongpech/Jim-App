class WorkoutExercise {
  late int id;
  final String exerciseId;
  int setCount;
  int restTimeSecond;

  WorkoutExercise({
    this.id = 0,
    required this.exerciseId,
    required this.setCount,
    required this.restTimeSecond,
  });

  /// Create a new [WorkoutExercise] from a JSON object
  WorkoutExercise copyWith({
    String? exerciseId,
    int? setCount,
    int? restTimeSecond,
  }) {
    return WorkoutExercise(
      exerciseId: exerciseId ?? this.exerciseId,
      setCount: setCount ?? this.setCount,
      restTimeSecond: restTimeSecond ?? this.restTimeSecond,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': exerciseId,
      'restTimeSecond': restTimeSecond,
      'setCount': setCount
    };
  }

  @override
  String toString() {
    return 'WorkoutExercise{\n  exerciseId: $exerciseId,\n  set: $setCount,\n  restTimeSecond: $restTimeSecond\n}';
  }

  static Future<List<WorkoutExercise>> fromJson(List<dynamic> json) async {
    return json
        .map((item) => WorkoutExercise(
              id: item['id'],
              exerciseId: item['exerciseId'],
              setCount: item['setCount'],
              restTimeSecond: item['restTimeSecond'],
            ))
        .toList();
  }
}
