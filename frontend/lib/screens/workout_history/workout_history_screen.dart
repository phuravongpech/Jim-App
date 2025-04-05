import 'package:flutter/material.dart';
import 'package:frontend/models/workout_session.dart';
import 'package:frontend/repository/workout_repository.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/navigation/jim_nav_bar.dart';
import 'package:frontend/widgets/navigation/jim_top_bar.dart';
import 'package:get/get.dart';
import 'workout_history_detail_screen.dart';

class WorkoutHistoryScreen extends StatefulWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  State<WorkoutHistoryScreen> createState() => _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  late Future<List<WorkoutSession>> _sessionsFuture;
  final _repository = Get.find<WorkoutRepository>();

  @override
  void initState() {
    super.initState();
    _sessionsFuture = _repository.getWorkoutSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: JimTopBar(
        title: 'Workout History',
      ),
      body: FutureBuilder<List<WorkoutSession>>(
        future: _sessionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return _buildSessionList(snapshot.data ?? []);
        },
      ),
      bottomNavigationBar: const JimNavBar(),
    );
  }

  Widget _buildSessionList(List<WorkoutSession> sessions) {
    // Sort sessions by date, newest first
    final sortedSessions = List<WorkoutSession>.from(sessions)
      ..sort((a, b) => b.startWorkout.compareTo(a.startWorkout));

    return ListView.builder(
      itemCount: sortedSessions.length,
      itemBuilder: (context, index) {
        final session = sortedSessions[index];
        return WorkoutHistoryCard(
          session: session,
          date: session.startWorkout.day == DateTime.now().day
              ? 'Today'
              : session.formattedDate,
        );
      },
    );
  }
}

class WorkoutHistoryCard extends StatelessWidget {
  final WorkoutSession session;
  final String date;

  const WorkoutHistoryCard({
    super.key,
    required this.session,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context, session),
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: JimSpacings.s, horizontal: JimSpacings.l),
        padding: const EdgeInsets.all(JimSpacings.l),
        decoration: BoxDecoration(
          color: JimColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(session.workoutName,
                      style: JimTextStyles.heading,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(date,
                    style:
                        JimTextStyles.label.copyWith(color: JimColors.primary)),
              ],
            ),
            if (session.workoutDescription.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: JimSpacings.xs),
                child: Text(
                  session.workoutDescription,
                  style: JimTextStyles.subBody
                      .copyWith(color: JimColors.textSecondary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            const SizedBox(height: JimSpacings.xs),
            const Divider(color: JimColors.stroke, thickness: 1),
            Column(children: _buildExerciseList()),
            if (session.exercises.length > 3)
              Padding(
                padding: const EdgeInsets.only(top: JimSpacings.s),
                child: Text(
                  '+ ${session.exercises.length - 3} more exercises',
                  style: JimTextStyles.label
                      .copyWith(color: JimColors.textSecondary),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildExerciseList() {
    return session.exercises
        .take(3)
        .map((exercise) => Padding(
              padding: const EdgeInsets.symmetric(vertical: JimSpacings.xs),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(exercise.exerciseName,
                        style: JimTextStyles.subBody
                            .copyWith(color: JimColors.textPrimary)),
                  ),
                  Expanded(
                    child: Text('${exercise.setCount} sets',
                        style: JimTextStyles.label
                            .copyWith(color: JimColors.textSecondary)),
                  ),
                  Expanded(
                    child: Text('${exercise.restTimeSecond}s',
                        style: JimTextStyles.label
                            .copyWith(color: JimColors.textSecondary)),
                  ),
                ],
              ),
            ))
        .toList();
  }

  void _navigateToDetail(BuildContext context, WorkoutSession session) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutHistoryDetailScreen(sessionId: session.id),
      ),
    );
  }
}
