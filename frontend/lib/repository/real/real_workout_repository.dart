import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/models/workout.dart';
import 'package:frontend/models/workout_exercise.dart';
import 'package:frontend/repository/workout_repository.dart';
import 'package:http/http.dart';

class RealWorkoutRepository implements WorkoutRepository {
  final String backendUrl = dotenv.env['BACKEND_URL'] ?? '';

  @override
  Future<void> saveWorkouts({
    required String name,
    required String description,
    required List<Exercise> exercises,
    required List<WorkoutExercise> workoutExercises,
  }) async {
    try {
      final response = await post(
        Uri.parse('$backendUrl/workouts'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'description': description,
          'exercises': exercises.map((e) => e.toJson()).toList(),
          'workoutExercises':
              workoutExercises.map((we) => we.toJson()).toList(),
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to save workouts');
      }
    } catch (e) {
      throw Exception('Error saving workouts: $e');
    }
  }

  @override
  Future<List<WorkoutExercise>> getWorkoutExercises(String workoutId) async {
    try {
      final response =
          await get(Uri.parse('$backendUrl/workoutexercise/$workoutId'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<WorkoutExercise>.from(
            data.map((we) => WorkoutExercise.fromJson(we)));
      } else {
        throw Exception('Failed to load workout details');
      }
    } catch (e) {
      throw Exception('Error fetching workout details: $e');
    }
  }

  @override
  Future<List<Workout>> getWorkoutWithExercises() async {
    try {
      final response = await get(Uri.parse('$backendUrl/workouts/exercises'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        var test = data.map((json) => Workout.fromJson(json)).toList();
        return test;
      } else {
        throw Exception('Failed to load workout details');
      }
    } catch (e) {
      throw Exception('Error fetching workout details: $e');
    }
  }

  @override
  Future<Workout> getWorkoutWithExercisesFor(String workoutId) async {
    try {
      final response = await get(
        Uri.parse('$backendUrl/workouts/exercises/$workoutId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Workout.fromJson(data);
      } else {
        throw Exception('Failed to load workout details');
      }
    } catch (e) {
      throw Exception('Error fetching workout details: $e');
    }
  }

  @override
  Future<void> deleteWorkout(String workoutId) async {
    try {
      final response =
          await delete(Uri.parse('$backendUrl/workouts/$workoutId'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete workout');
      }
    } catch (e) {
      throw Exception('Error deleting workout: $e');
    }
  }

  @override
  Future<void> updateWorkout({
    required String workoutId,
    required String name,
    required String description,
    required List<Exercise> exercises,
    required List<WorkoutExercise> workoutExercises,
  }) async {
    try {
      final response = await put(
        Uri.parse('$backendUrl/workouts/$workoutId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'description': description,
          'exercises': exercises.map((e) => e.toJson()).toList(),
          'workoutExercises':
              workoutExercises.map((we) => we.toJson()).toList(),
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update workout');
      }
    } catch (e) {
      throw Exception('Error updating workout: $e');
    }
  }
}
