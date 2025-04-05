import 'package:flutter/material.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/models/logged_set.dart';
import 'package:frontend/models/workout_exercise.dart';
import 'package:frontend/models/workout_with_exercise.dart';
import 'package:frontend/services/workout_session_service.dart';
import 'package:frontend/theme/theme.dart';
import 'package:get/get.dart';

class WorkoutSummaryScreen extends StatelessWidget {
  final WorkoutSessionService _service = WorkoutSessionService.instance;

  WorkoutSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutExercises = _service.activeWorkoutExercises;
    final loggedSets = _service.loggedSets;

    return Scaffold(
      appBar: AppBar(
        title: Text(_service.activeWorkout.value?.name ?? 'Workout Summary',
            style: JimTextStyles.heading),
        centerTitle: true,
        backgroundColor: JimColors.white,
        elevation: 2,
        shadowColor: JimColors.whiteGrey,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  bottom: 80), // Add padding to avoid overlap with the button
              child: Padding(
                padding: EdgeInsets.all(JimSpacings.m),
                child: Column(
                  children: [
                    _buildSummaryHeader(),
                    SizedBox(height: JimSpacings.xl),
                    ...workoutExercises.map((workoutExercise) {
                      // Filter logged sets for this workout exercise
                      final exerciseSets = loggedSets
                          .where((set) =>
                              set.workoutExerciseId == workoutExercise.id)
                          .toList();

                      return _buildExerciseCard(workoutExercise, exerciseSets);
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(JimSpacings.m),
            child: _buildFinishButton(context),
          ),
          const SizedBox(height: 20), // Space between button and bottom
        ],
      ),
    );
  }

  Widget _buildSummaryHeader() {
    return Card(
      color: JimColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(JimSpacings.radius),
        side: BorderSide(color: JimColors.stroke, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(JimSpacings.m),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(Icons.calendar_today,
                    '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'),
                // _buildInfoItem(Icons.access_time, '69h 30m'),
              ],
            ),
            const SizedBox(height: JimSpacings.l),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: JimColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: JimColors.primary, width: 2),
              ),
              child: Icon(Icons.check, size: 60, color: JimColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: JimIconSizes.small, color: JimColors.primary),
        const SizedBox(width: JimSpacings.xs),
        Text(text, style: JimTextStyles.body),
      ],
    );
  }

  Widget _buildExerciseCard(
      CustomWorkoutExercise workoutExercise, List<LoggedSet> sets) {
    // Get exercise details from service
    final exercise = _service.xExercise.firstWhere(
      (e) => e.id == workoutExercise.exerciseId,
      orElse: () => Exercise(
        id: '',
        name: 'Unknown Exercise',
        gifUrl: '',
        bodyPart: '',
        equipment: '',
        target: '',
        instructions: [],
      ),
    );

    return Card(
      color: JimColors.white,
      elevation: 0,
      margin: EdgeInsets.only(bottom: JimSpacings.m),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(JimSpacings.radius),
        side: BorderSide(color: JimColors.stroke),
      ),
      child: Padding(
        padding: EdgeInsets.all(JimSpacings.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(exercise.name, style: JimTextStyles.title),
            SizedBox(height: JimSpacings.s),
            Text('Target Sets: ${workoutExercise.setCount}',
                style: JimTextStyles.subBody),
            SizedBox(height: JimSpacings.m),
            Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(vertical: JimSpacings.xs),
                  child: Row(
                    children: [
                      Expanded(child: Text('Set', style: JimTextStyles.label)),
                      Expanded(
                          child: Text('Weight', style: JimTextStyles.label)),
                      Expanded(child: Text('Reps', style: JimTextStyles.label)),
                    ],
                  ),
                ),
                // Set rows
                ...sets.map((set) => _buildSetRow(set)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetRow(LoggedSet set) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: JimSpacings.xs),
      child: Row(
        children: [
          Expanded(
            child: Text('Set ${set.setNumber}', style: JimTextStyles.body),
          ),
          Expanded(
            child: Text('${set.weight?.toStringAsFixed(1) ?? '-'} kg',
                style: JimTextStyles.body),
          ),
          Expanded(
            child: Text('${set.rep ?? 0}', style: JimTextStyles.body),
          ),
        ],
      ),
    );
  }

  Widget _buildFinishButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: JimColors.primary,
          padding: const EdgeInsets.symmetric(vertical: JimSpacings.m),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(JimSpacings.radius)),
        ),
        onPressed: () {
          // First clear the session data
          _service.clearSessionData();
          // Then navigate to home using GetX navigation
          Get.offAllNamed('/workout');
        },
        child: Text('Back to Home', style: JimTextStyles.button),
      ),
    );
  }
}
