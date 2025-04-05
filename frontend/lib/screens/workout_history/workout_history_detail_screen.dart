// workout_history_detail_screen.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:frontend/models/logged_exercise.dart';
import 'package:frontend/models/logged_set.dart';
import 'package:frontend/models/workout_session.dart';
import 'package:frontend/models/workout_session_detail.dart';
import 'package:frontend/repository/workout_repository.dart';
import 'package:frontend/theme/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WorkoutHistoryDetailScreen extends StatelessWidget {
  final int sessionId;
  final DateFormat dateFormat = DateFormat('MMM dd,  yyyy');
  final DateFormat timeFormat = DateFormat('HH:mm');

  WorkoutHistoryDetailScreen({
    super.key,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    final repository = Get.find<WorkoutRepository>();

    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: JimColors.textPrimary),
          onPressed: () {
            Get.back();
          }, // Change this line
        ),
        title: Text('Workout Details', style: JimTextStyles.heading),
        centerTitle: true,
        backgroundColor: JimColors.white,
        elevation: 2,
      ),
      body: FutureBuilder<WorkoutSessionDetail>(
        future: repository.getWorkoutSessionDetail(sessionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return _buildDetailContent(snapshot.data!);
        },
      ),
    );
  }

  Widget _buildDetailContent(WorkoutSessionDetail session) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(JimSpacings.m),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: JimSpacings.s,
        ),
        child: Column(
          children: [
            _buildSessionHeader(session),
            const SizedBox(height: JimSpacings.xl),
            ..._buildExerciseCards(session.loggedExercises),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionHeader(WorkoutSessionDetail session) {
    return Container(
      decoration: BoxDecoration(
        color: JimColors.white,
        borderRadius: BorderRadius.circular(JimSpacings.radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(JimSpacings.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(session.workoutName,
              style: JimTextStyles.title.copyWith(
                fontSize: 22,
              )),
          if (session.workoutDescription.isNotEmpty) ...[
            const SizedBox(height: JimSpacings.xs),
            Text(
              session.workoutDescription,
              style: JimTextStyles.body.copyWith(
                color: JimColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: JimSpacings.m),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem(Icons.calendar_today,
                  dateFormat.format(session.startWorkout)),
              _buildInfoItem(Icons.access_time, session.duration),
            ],
          ),
          const SizedBox(height: JimSpacings.s),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem(Icons.timer,
                  '${timeFormat.format(session.startWorkout)}  -  ${timeFormat.format(session.endWorkout)}'),
              _buildInfoItem(Icons.list_alt,
                  '${session.loggedExercises.length} exercises'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: JimColors.primary),
        const SizedBox(width: JimSpacings.xs),
        Text(text, style: JimTextStyles.body),
      ],
    );
  }

  List<Widget> _buildExerciseCards(List<LoggedExercise> exercises) {
    return exercises
        .map((exercise) => Container(
              margin: const EdgeInsets.only(bottom: JimSpacings.m),
              decoration: BoxDecoration(
                color: JimColors.white,
                borderRadius: BorderRadius.circular(JimSpacings.radius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(JimSpacings.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exercise.exerciseName, style: JimTextStyles.title),
                  _buildSetTable(exercise.sets),
                  const SizedBox(height: JimSpacings.s),
                  Text('Rest Time: ${exercise.restTime}s',
                      style: JimTextStyles.label),
                ],
              ),
            ))
        .toList();
  }

  Widget _buildSetTable(List<LoggedSet> sets) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: JimColors.stroke)),
          ),
          children: [
            _buildTableHeader('Set'),
            _buildTableHeader('Weight (kg)'),
            _buildTableHeader('Reps'),
          ],
        ),
        ...sets.map((set) => TableRow(
              children: [
                _buildTableCell(set.setNumber.toString()),
                _buildTableCell(
                    set.weight != null ? set.weight.toString() : '0'),
                _buildTableCell(set.rep.toString()),
              ],
            )),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: JimSpacings.s),
      child: Text(text, style: JimTextStyles.label),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: JimSpacings.s),
      child: Text(text, style: JimTextStyles.body),
    );
  }
}
