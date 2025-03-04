import '../utils/uuid_utils.dart';
import 'exercise.dart';

class Workout {
  final String id;
  final String name;
  final String description;
  final List<Exercise> exercises;
  bool isCompleted;

  Workout({
    String? id,
    required this.name,
    required this.description,
    required this.exercises,
    this.isCompleted = false,
  }) : id = id ?? UuidUtils.generateUuid();

  @override
  String toString() {
    return 'Workout{\n'
        '  name: $name,\n'
        '  description: $description,\n'
        '  isCompleted: $isCompleted,\n'
        '  exercises: $exercises,\n'
        '}';
  }

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      exercises: (json['exercises'] as List)
          .map((exercise) => Exercise.fromJson(exercise))
          .toList(),
      isCompleted: json['isCompleted'],
    );
  }
}
