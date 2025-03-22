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
