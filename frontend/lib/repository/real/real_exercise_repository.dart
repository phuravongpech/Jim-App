import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/repository/exercise_repository.dart';
import 'package:frontend/utils/fuzzywuzzy.dart';
import 'package:http/http.dart';

class RealExerciseRepository implements ExerciseRepository {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';
  final String apiHost = dotenv.env['API_HOST'] ?? '';
  final String apiKey = dotenv.env['API_KEY'] ?? '';
  final String backendUrl = dotenv.env['BACKEND_URL'] ?? '';

  @override
  Future<List<Exercise>> fetchExercises({
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await get(
        Uri.parse('$baseUrl/exercises?offset=$offset'),
        headers: {
          "x-rapidapi-host": apiHost,
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
            "x-rapidapi-host": apiHost,
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

  @override
  Future<Exercise> getExerciseById({required String id}) async {
    try {
      final response =
          await get(Uri.parse('$backendUrl/exercises/$id'), headers: {
        "x-rapidapi-host": baseUrl,
        "x-rapidapi-key": apiKey,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data.map((json) => Exercise.fromJson(json));
      } else {
        throw Exception('Failed to search exercises');
      }
    } catch (e) {
      throw Exception('Error searching exercises: $e');
    }
  }
}
