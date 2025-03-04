import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/repository/exercise_repository.dart';
import 'package:frontend/utils/fuzzywuzzy.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ExerciseService implements ExerciseRepository {
  final log = Logger();
  final String baseUrl = dotenv.env['BASE_URL'] ?? 'default_url';
  final String apiKey = dotenv.env['API_KEY'] ?? 'default_key';

  @override
  Future<List<Exercise>> getExercises({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await get(
        Uri.parse('$baseUrl/exercises?offset=${page * limit}&limit=$limit'),
        headers: {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
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
  Future<List<Exercise>> searchExercises({required String query}) async {
    String newQuery = Fuzzywuzzy.searchForExercise(query);

    try {
      final response = await get(
        Uri.parse('$baseUrl/exercises/name/$newQuery?offset=0&limit=10'),
        headers: {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
        },
      );

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
