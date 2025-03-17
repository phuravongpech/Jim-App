import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/repository/exercise_repository.dart';
import 'package:frontend/utils/fuzzywuzzy.dart';
import 'package:http/http.dart';

class RealExerciseRepository implements ExerciseRepository {
  final String baseUrl = dotenv.env['BASE_URL'] ?? 'default_url';
  final String apiKey = dotenv.env['API_KEY'] ?? 'default_key';

  @override
  Future<List<Exercise>> fetchExercises({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await get(
        Uri.parse('$baseUrl/exercises'),
        headers: {
          "x-rapidapi-host": baseUrl,
          "x-rapidapi-key": apiKey,
        },
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
      final response = await get(
          Uri.parse('$baseUrl/exercises/name/$bestMatchStr'),
          headers: {
            "x-rapidapi-host": baseUrl,
            "x-rapidapi-key": apiKey,
          });

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
}
