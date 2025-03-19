import 'package:flutter/material.dart';
import 'package:frontend/controller/workout_controller.dart';
import 'package:frontend/controller/workout_session_controller.dart';
import 'package:frontend/screens/workout_session/widgets/set_log_button.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/action/jim_icon_button.dart';
import 'package:get/get.dart';

import '../../widgets/navigation/jim_top_bar.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final WorkoutController controller = Get.put(WorkoutController());

  WorkoutDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutId = Get.arguments is String ? Get.arguments : null;

    if (workoutId != null && controller.workout.value == null) {
      controller.fetchWorkoutDetail(workoutId);
    }

    final sesionController = Get.find<WorkoutSessionController>();

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
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        final workout = controller.workout.value;

        if (workout == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
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
                child: ListView.separated(
                  itemCount: workout.exercises.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final exercise = workout.exercises[index];
                    return ListTile(
                      title: Text(exercise.name),
                      // subtitle: Text('Sets: ${exercise.} | Reps: ${exercise.reps}'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // Handle exercise tap
                      },
                    );
                  },
                ),
              ),
              SetLogButton(text: "Start Workout", onPressed: () {}),
              SizedBox(
                height: 20,
              )
            ],
          ),
        );
      }),
    );
  }
}
