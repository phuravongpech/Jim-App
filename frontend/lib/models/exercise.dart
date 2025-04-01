class Exercise {
  final String id;
  final String name;
  final String gifUrl;
  final String bodyPart;
  final String equipment;
  final String target;
  final List<String> instructions;

  Exercise({
    required this.id,
    required this.name,
    required this.gifUrl,
    required this.bodyPart,
    required this.equipment,
    required this.target,
    required this.instructions,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'].toString(),
      name: json['name'].toString(),
      gifUrl: json['gifUrl'].toString(),
      bodyPart: json['bodyPart'].toString(),
      equipment: json['equipment'].toString(),
      target: json['target'].toString(),
      instructions: List<String>.from(json['instructions']),
    );
  }

  factory Exercise.fromCustomWorkoutExercise(dynamic customWorkoutExercise) {
    // First approach: Try direct access if properties exist at top level
    try {
      return Exercise(
        id: customWorkoutExercise.exerciseId?.toString() ?? '',
        name: customWorkoutExercise.name?.toString() ?? '',
        gifUrl: customWorkoutExercise.gifUrl?.toString() ?? '',
        bodyPart: customWorkoutExercise.bodyPart?.toString() ?? '',
        equipment: customWorkoutExercise.equipment?.toString() ?? '',
        target: customWorkoutExercise.target?.toString() ?? '',
        instructions: (customWorkoutExercise.instructions is List)
            ? List<String>.from(customWorkoutExercise.instructions)
            : [],
      );
    } catch (e) {
      // Fallback approach: Try nested exercise object
      try {
        return Exercise(
          id: customWorkoutExercise.exercise?.id?.toString() ??
              customWorkoutExercise.exerciseId?.toString() ??
              '',
          name: customWorkoutExercise.exercise?.name?.toString() ?? '',
          gifUrl: customWorkoutExercise.exercise?.gifUrl?.toString() ?? '',
          bodyPart: customWorkoutExercise.exercise?.bodyPart?.toString() ?? '',
          equipment:
              customWorkoutExercise.exercise?.equipment?.toString() ?? '',
          target: customWorkoutExercise.exercise?.target?.toString() ?? '',
          instructions: (customWorkoutExercise.exercise?.instructions is List)
              ? List<String>.from(customWorkoutExercise.exercise.instructions)
              : [],
        );
      } catch (e) {
        // Ultimate fallback with default values
        return Exercise(
          id: '',
          name: 'Unknown Exercise',
          gifUrl: '',
          bodyPart: '',
          equipment: '',
          target: '',
          instructions: [],
        );
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gifUrl': gifUrl,
      'bodyPart': bodyPart,
      'equipment': equipment,
      'target': target,
      'instructions': instructions,
    };
  }

  @override
  String toString() {
    return 'Exercise{\n  id: $id,\n  name: $name,\n  gifUrl: $gifUrl,\n  bodyPart: $bodyPart,\n  equipment: $equipment,\n  target: $target,\n  instructions: $instructions\n}';
  }
}
