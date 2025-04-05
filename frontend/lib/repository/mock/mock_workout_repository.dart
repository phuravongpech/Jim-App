import 'dart:convert';

import 'package:frontend/models/exercise.dart';
import 'package:frontend/models/logged_set.dart';
import 'package:frontend/models/workout.dart';
import 'package:frontend/models/workout_exercise.dart';
import 'package:frontend/models/workout_session.dart';
import 'package:frontend/models/workout_session_detail.dart';
import 'package:frontend/repository/workout_repository.dart';
import 'package:http/http.dart';

import '../../models/workout_with_exercise.dart';

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
      final response = await get(
        Uri.parse('$baseUrl/workoutExercises?workoutId=$workoutId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<WorkoutExercise>.from(
            data.map((we) => WorkoutExercise.fromJson(we)));
      } else {
        throw Exception('Failed to load workout exercises');
      }
    } catch (e) {
      throw Exception('Error fetching workout exercises: $e');
    }
  }

  // Below method was not needed after we have backend
  // So not implemented properly
  @override
  Future<List<Workout>> getWorkoutWithExercises() {
    throw UnimplementedError();
  }

  @override
  Future<WorkoutWithExercise> getWorkoutWithExercisesFor(String workoutId) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWorkout(String workoutId) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateWorkout(
      {required String workoutId,
      required String name,
      required String description,
      required List<Exercise> exercises,
      required List<WorkoutExercise> workoutExercises}) {
    throw UnimplementedError();
  }

  @override
  Future<void> saveLoggedSets(
      {required String workoutId,
      required DateTime startWorkout,
      required DateTime endWorkout,
      required List<LoggedSet> loggedSets}) {
    throw UnimplementedError();
  }

  @override
  Future<List<WorkoutSession>> getWorkoutSessions() {
    throw UnimplementedError();
  }

  @override
  Future<WorkoutSessionDetail> getWorkoutSessionDetail(int sessionId) {
    throw UnimplementedError();
  }
}
