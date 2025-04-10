import 'package:flutter/material.dart';
import 'package:frontend/controller/workout_controller.dart';
import 'package:frontend/controller/workout_session_controller.dart';
import 'package:frontend/screens/workout_session/set_log_screen.dart';
import 'package:frontend/screens/workout_session/widgets/set_log_button.dart';
import 'package:frontend/services/workout_session_service.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/action/jim_icon_button.dart';
import 'package:frontend/widgets/navigation/jim_top_bar.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

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
  final log = Logger();

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
      log.w('Loading workout data, please wait...');
      return false;
    }
    if (hasError.value ||
        _service.activeWorkout.value == null ||
        _service.activeWorkoutExercises.isEmpty) {
      log.w('No workout data available or workout is empty');
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
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  foregroundColor: JimColors.black,
                  backgroundColor: JimColors.white,
                  side: const BorderSide(color: Colors.black),
                  minimumSize: const Size(120, 50),
                ),
                child: const Text('Cancel', style: TextStyle(fontSize: 16)),
              ),
              ElevatedButton(
                onPressed: () {
                  _deleteWorkout(workoutId);
                  Get.offNamed('/workout');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: JimColors.white,
                  backgroundColor: JimColors.error,
                  minimumSize: const Size(120, 50),
                ),
                child: const Text('Yes', style: TextStyle(fontSize: 16)),
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
    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
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
                Text(errorMessage.value, style: JimTextStyles.body),
                const SizedBox(height: JimSpacings.m),
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
          padding: const EdgeInsets.all(JimSpacings.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                workout.name,
                style: JimTextStyles.heading.copyWith(fontSize: 22),
              ),
              const SizedBox(height: JimSpacings.s),
              if (workout.description.isNotEmpty) ...[
                Text(workout.description, style: JimTextStyles.body),
                const SizedBox(height: JimSpacings.m),
              ],
              const SizedBox(height: JimSpacings.l),
              Text('Exercises', style: JimTextStyles.title),
              Expanded(
                child: Obx(() {
                  return ListView.separated(
                    itemCount: _service.activeWorkoutExercises.length,
                    separatorBuilder: (context, index) =>
                        const Divider(color: JimColors.stroke),
                    itemBuilder: (context, index) {
                      final workoutExercise =
                          _service.activeWorkoutExercises[index];
                      final exercise = _service.xExercise[index];
                      return ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        title: Text(exercise.name, style: JimTextStyles.body),
                        subtitle: Text(
                          'Sets: ${workoutExercise.setCount} | Rest: ${workoutExercise.restTimeSecond}s',
                          style: JimTextStyles.label,
                        ),
                        trailing: const Icon(Icons.chevron_right,
                            color: JimColors.textSecondary),
                        onTap: () {
                          // Optionally handle tap on individual exercise
                        },
                      );
                    },
                  );
                }),
              ),
              SetLogButton(
                text: "Start Workout",
                onPressed: _startWorkout,
              ),
              const SizedBox(height: JimSpacings.xl),
            ],
          ),
        );
      }),
    );
  }
}
