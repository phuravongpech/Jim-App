import 'dart:convert';

import 'package:frontend/models/exercise.dart';
import 'package:frontend/models/workout_exercise.dart';
import 'package:frontend/repository/workout_repository.dart';
import 'package:http/http.dart';

import '../models/workout.dart';

class MockWorkoutService extends WorkoutRepository {
  static final MockWorkoutService _instance = MockWorkoutService._internal();
  factory MockWorkoutService() => _instance;
  MockWorkoutService._internal();

  final String baseUrl = 'http://localhost:3000';

  @override
  Future<List<Workout>> getWorkouts() async {
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
          // 'workoutExercises': workoutExercises.map((we) => we.toJson()).toList(),
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to save workouts');
      }
    } catch (e) {
      throw Exception('Error saving workouts: $e');
    }
  }
}
