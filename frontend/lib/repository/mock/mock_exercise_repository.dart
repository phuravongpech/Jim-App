import 'dart:convert';

import 'package:frontend/models/exercise.dart';
import 'package:frontend/repository/exercise_repository.dart';
import 'package:http/http.dart';

import '../../utils/fuzzywuzzy.dart';

class MockExerciseRepository extends ExerciseRepository {
  static const String baseUrl = 'http://localhost:3000';

  @override
  Future<List<Exercise>> fetchExercises({
    required int page,
    required int limit,
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

  @override
  Future<List<Exercise>> searchExercises({
    required int page,
    required int limit,
    required String query,
  }) async {
    String bestMatchStr = Fuzzywuzzy.searchForExercise(query);

    try {
      final response =
          await get(Uri.parse('$baseUrl/exercises/name/$bestMatchStr'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Exercise.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search exercises');
      }
    } catch (e) {
      throw Exception('Error searching exercises: $e');
    }
  }

  @override
  Future<Exercise> getExerciseById({required String id}) async {
    try {
      final response = await get(
        Uri.parse('$baseUrl/exercises/$id'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Exercise.fromJson(data);
      } else {
        throw Exception('Failed to get exercise by id');
      }
    } catch (e) {
      throw Exception('exercise error fetching from id');
    }
  }
}
