import 'dart:convert';

import 'package:frontend/models/exercise.dart';
import 'package:frontend/models/workout.dart';
import 'package:frontend/models/workout_exercise.dart';
import 'package:frontend/repository/workout_repository.dart';
import 'package:http/http.dart';

class MockWorkoutRepository extends WorkoutRepository {
  static const String baseUrl = 'http://localhost:3000';

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
          'workoutExercises': workoutExercises.map((we) => we.toJson()).toList(),
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
      final response = await get(
        Uri.parse('$baseUrl/workoutExercises?workoutId=$workoutId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<WorkoutExercise>.from(data.map((we) => WorkoutExercise.fromJson(we)));
      } else {
        throw Exception('Failed to load workout exercises');
      }
    } catch (e) {
      throw Exception('Error fetching workout exercises: $e');
    }
  }
  
  @override
  Future<List<Workout>> getExerciseForWorkout(String workoutId) {
    // TODO: implement getExerciseForWorkout
    throw UnimplementedError();
  }
  
  @override
  Future<List<Workout>> getWorkoutWithExercises() {
    // TODO: implement getWorkoutWithExercises
    throw UnimplementedError();
  }
  
  @override
  Future<Workout> getWorkoutWithExercisesFor(String workoutId) {
    // TODO: implement getWorkoutWithExercisesFor
    throw UnimplementedError();
  }
}
