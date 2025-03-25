import 'package:flutter/material.dart';
import 'package:frontend/controller/workout_controller.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/screens/workout_session/set_log_screen.dart';
import 'package:frontend/services/exercise_service.dart';
import 'package:frontend/services/workout_session_service.dart';
import 'package:frontend/controller/workout_session_controller.dart';
import 'package:frontend/screens/workout_session/widgets/set_log_button.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/action/jim_icon_button.dart';
import 'package:get/get.dart';
import '../../widgets/navigation/jim_top_bar.dart';

class WorkoutDetailScreen extends StatelessWidget {
  WorkoutDetailScreen({super.key}) {
    _service = WorkoutSessionService.instance;
    final workoutId = Get.arguments as String?;
    if (workoutId != null) {
      _loadWorkout(workoutId);
    }
  }

  late final WorkoutSessionService _service;
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  Future<void> _loadWorkout(String id) async {
    try {
      isLoading(true);
      hasError(false);
      errorMessage('');

      final success = await _service.loadWorkout(id);
      if (!success) {
        throw Exception('Failed to load workout');
      }
    } catch (e) {
      hasError(true);
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void _startWorkout() {
    if (!_canStartWorkout()) return;
    Get.lazyPut(() => WorkoutSessionController());
    Get.to(() => SetLogScreen());
  }

  bool _canStartWorkout() {
    if (isLoading.value) {
      Get.snackbar('Error', 'Please wait for workout to load');
      return false;
    }

    if (hasError.value ||
        _service.activeWorkout.value == null ||
        _service.activeWorkoutExercises.isEmpty) {
      Get.snackbar('Error', 'Workout data not available');
      return false;
    }

    return true;
  }

  void _showDeleteDialog(String workoutId) {
    Get.dialog(
      AlertDialog(
        backgroundColor: JimColors.white,
        title: Text(
          'Delete Workout',
          style: JimTextStyles.heading,
        ),
        content: Text(
          'Are you sure you want to delete this workout?',
          style: JimTextStyles.body,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.black),
                  minimumSize: Size(120, 50),
                ),
                child: Text('Cancel', style: TextStyle(fontSize: 16)),
              ),
              ElevatedButton(
                onPressed: () {
                  _deleteWorkout(workoutId);
                  Get.offNamed('/workout');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  minimumSize: Size(120, 50),
                ),
                child: Text('Yes', style: TextStyle(fontSize: 16)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _deleteWorkout(String workoutId) async {
    try {
      final workoutController = Get.find<WorkoutController>();
      await workoutController.deleteWorkout(workoutId);
      Get.snackbar(
        'Success',
        'Workout deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        colorText: JimColors.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final exerciseService = ExerciseService.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: JimTopBar(
        title: "",
        leading: JimIconButton(
          icon: Icons.arrow_back,
          color: JimColors.black,
          onPressed: () => Get.back(),
        ),
        actions: [
          JimIconButton(
            icon: Icons.delete_outline,
            color: JimColors.error,
            onPressed: () => _showDeleteDialog(Get.arguments),
          ),
        ],
      ),
      body: Obx(() {
        if (isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(errorMessage.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _loadWorkout(Get.arguments),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final workout = _service.activeWorkout.value;
        if (workout == null) {
          return const Center(child: Text('No workout data available'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                workout.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              if (workout.description.isNotEmpty) ...[
                Text(
                  workout.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
              ],
              Text(
                'Exercises',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Obx(() => ListView.separated(
                      itemCount: _service.activeWorkoutExercises.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final workoutExercise =
                            _service.activeWorkoutExercises[index];
                        final exerciseFuture = exerciseService.repository
                            .getExerciseById(id: workoutExercise.exerciseId);

                        return FutureBuilder<Exercise>(
                          future: exerciseFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const ListTile(
                                title: Text('Loading...'),
                                trailing: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                ),
                              );
                            }

                            if (snapshot.hasError || !snapshot.hasData) {
                              return ListTile(
                                title: Text('Error loading exercise'),
                                subtitle: Text('Tap to retry'),
                                trailing: Icon(Icons.refresh),
                                onTap: () {
                                  // Add refresh logic here
                                },
                              );
                            }

                            final exercise = snapshot.data!;
                            return ListTile(
                              title: Text(exercise.name),
                              subtitle: Text(
                                'Sets: ${workoutExercise.setCount} | Rest: ${workoutExercise.restTimeSecond}s',
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                // Handle exercise tap
                              },
                            );
                          },
                        );
                      },
                    )),
              ),
              SetLogButton(
                text: "Start Workout",
                onPressed: _startWorkout,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
