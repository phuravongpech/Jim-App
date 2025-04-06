class Workout {
  final String id;
  final String name;
  final String description;
  final int exerciseCount;

  Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.exerciseCount,
  });

  @override
  String toString() {
    return 'Workout{\n'
        '  id: $id,\n'
        '  name: $name,\n'
        '  description: $description,\n'
        '  exercises: $exerciseCount,\n'
        '}';
  }

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      exerciseCount: json['exerciseCount'],
    );
  }
}
