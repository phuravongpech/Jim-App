import 'dart:convert';

import 'package:frontend/models/exercise.dart';
import 'package:frontend/models/workout.dart';
import 'package:frontend/models/workout_exercise.dart';
import 'package:frontend/repository/workout_repository.dart';
import 'package:frontend/utils/uuid_utils.dart';
import 'package:http/http.dart';

class MockWorkoutRepository extends WorkoutRepository {
  static const String baseUrl = 'http://localhost:3000';

  @override
  Future<List<Workout>> fetchWorkouts() async {
    try {
      final response = await get(
        Uri.parse('$baseUrl/workouts'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Workout.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load workouts');
      }
    } catch (e) {
      throw Exception('Error fetching workouts: $e');
    }
  }

  @override
  Future<Workout> getWorkoutById(String id) async {
    try {
      final response = await get(Uri.parse('$baseUrl/workouts/$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Workout.fromJson(data);
      } else {
        throw Exception('Failed to load workout details');
      }
    } catch (e) {
      throw Exception('Error fetching workout details: $e');
    }
  }

  @override
  Future<void> saveWorkouts({
    required String name,
    required String description,
    required List<Exercise> exercises,
    required List<WorkoutExercise> workoutExercises,
  }) async {
    try {
      final response = await post(
        Uri.parse('$baseUrl/workouts'),
        body: json.encode({
          'name': name,
          'description': description,
          'exercises': exercises.map((e) => e.toJson()).toList(),
          'workoutExercises': workoutExercises
              .map((we) =>
                  {...we.toJson(), 'global_id': UuidUtils.generateUuid()})
              .toList()
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to save workouts');
      }
    } catch (e) {
      throw Exception('Error saving workouts: $e');
    }
  }
}
