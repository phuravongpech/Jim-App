import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/exercise.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ExerciseService {
  final log = Logger();
  final String baseUrl = dotenv.env['BASE_URL'] ?? 'default_url';
  final String apiKey = dotenv.env['API_KEY'] ?? 'default_key';

  Future<List<Exercise>> getExercises({
    required int page,
    required int limit,
    required String bodyPart,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/exercises/bodyPart/$bodyPart?offset=${page * limit}&limit=$limit'),
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

  Future<List<Exercise>> searchExercises({required String query}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/exercises/name/$query'),
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
