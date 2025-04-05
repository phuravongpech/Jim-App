import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/models/logged_exercise.dart';
import 'package:frontend/models/logged_set.dart';
import 'package:frontend/models/workout.dart';
import 'package:frontend/models/workout_exercise.dart';
import 'package:frontend/models/workout_session.dart';
import 'package:frontend/models/workout_session_detail.dart';
import 'package:frontend/repository/workout_repository.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../../models/workout_with_exercise.dart';

class RealWorkoutRepository implements WorkoutRepository {
  final String backendUrl = dotenv.env['BACKEND_URL'] ?? '';

  @override
  Future<String> saveWorkouts({
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

      // We want the new id assigned at the backend immediately
      // So that we can push the workout card with id attaced without having to hot reload the app
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return responseBody['id'].toString();
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
  Future<WorkoutWithExercise> getWorkoutWithExercisesFor(
      String workoutId) async {
    try {
      final response = await get(
        Uri.parse('$backendUrl/workouts/exercises/$workoutId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WorkoutWithExercise.fromJson(data);
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

  @override
  Future<void> saveLoggedSets({
    required String workoutId,
    required DateTime startWorkout,
    required DateTime endWorkout,
    required List<LoggedSet> loggedSets,
  }) async {
    try {
      final response = await post(
        Uri.parse('$backendUrl/LoggedSets'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'workoutId': int.parse(workoutId),
          'startWorkout': startWorkout.toUtc().toIso8601String(),
          'endWorkout': endWorkout.toUtc().toIso8601String(),
          'loggedSets': loggedSets
              .map((set) => {
                    'workoutExerciseId': set.workoutExerciseId,
                    'weight': set.weight,
                    'rep': set.rep,
                    'setNumber': set.setNumber,
                  })
              .toList(),
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to save logged sets');
      }
    } catch (e) {
      throw Exception('Error saving logged sets: $e');
    }
  }

  @override
  Future<List<WorkoutSession>> getWorkoutSessions() async {
    try {
      final response = await get(Uri.parse('$backendUrl/workout-sessions'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => WorkoutSession.fromJson(json)).toList();
      }
      throw Exception('Failed to load sessions: ${response.statusCode}');
    } catch (e) {
      Logger().e('Error fetching sessions: $e');
      throw Exception('Failed to load workout sessions');
    }
  }

  @override
  Future<WorkoutSessionDetail> getWorkoutSessionDetail(int sessionId) async {
    try {
      final response = await get(
        Uri.parse('$backendUrl/workout-sessions/$sessionId'),
      );

      Logger().d(
        'Response from getWorkoutSessionDetail: ${response.statusCode} ${response.body}',
      );
      if (response.statusCode == 200) {
        return WorkoutSessionDetail.fromJson(json.decode(response.body));
      }
      throw Exception('Failed to load session: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error fetching session details: $e');
    }
  }
}
