import 'dart:convert';

import 'package:frontend/models/exercise.dart';
import 'package:frontend/repository/exercise_repository.dart';
import 'package:http/http.dart';

class MockExerciseService extends ExerciseRepository {
  static final MockExerciseService _instance = MockExerciseService._internal();
  factory MockExerciseService() => _instance;
  MockExerciseService._internal();

  final String baseUrl = 'http://localhost:3000';

  @override
  Future<List<Exercise>> getExercises({
    required int page,
    required int limit,
    required String bodyPart,
  }) async {
    try {
      final response = await get(
        Uri.parse('$baseUrl/exercises'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Exercise.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load exercises');
      }
    } catch (e) {
      throw Exception('Error fetching exercises: $e');
    }
  }
}
