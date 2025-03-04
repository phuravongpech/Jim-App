import 'dart:convert';

import 'package:frontend/models/exercise.dart';
import 'package:frontend/repository/exercise_repository.dart';
import 'package:http/http.dart';

class MockExerciseService extends ExerciseRepository {
  final String apiUrl = "http://localhost:3000/users";

  @override
  Future<List<Exercise>> getExercises() async {
    final response = await get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Exercise.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load users");
    }
  }
}
