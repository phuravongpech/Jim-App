class Exercise {
  final String id;
  final String name;
  final String gifUrl;
  final String bodyPart;
  final String equipment;
  final String target;
  final List<String>? instructions;
  final List<String>? secondaryMuscles;
  bool isFavorite;

  Exercise(
      {required this.id,
      required this.name,
      required this.gifUrl,
      required this.bodyPart,
      required this.equipment,
      required this.target,
      this.instructions,
      this.secondaryMuscles,
      this.isFavorite = false});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      gifUrl: json['gifUrl']?.toString() ?? '',
      bodyPart: json['bodyPart']?.toString() ?? '',
      equipment: json['equipment']?.toString() ?? '',
      target: json['target']?.toString() ?? '',
      instructions: (json['instructions'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList(),
      secondaryMuscles: (json['secondaryMuscles'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList(),
    );
  }

  @override
  String toString() {
    return 'Exercise{\n  name: $name,\n  url: $gifUrl,}';
  }
}
