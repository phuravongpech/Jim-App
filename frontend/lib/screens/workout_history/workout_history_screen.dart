// workout_history_screen.dart
import 'package:flutter/material.dart';
import 'package:frontend/screens/workout_history/workout_history_detail_screen.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/action/jim_text_button.dart';
import 'package:frontend/widgets/navigation/jim_nav_bar.dart';
import 'package:frontend/widgets/navigation/jim_top_bar.dart';

class WorkoutHistoryScreen extends StatelessWidget {
  // Static data for demonstration
  final List<Map<String, dynamic>> workoutSessions = [
    {
      'id': '1',
      'name': 'Full Body Strength',
      'date': 'Feb 15, 2024',
      'exercises': [
        {'name': 'Barbell Squats', 'sets': 3, 'restTime': 90},
        {'name': 'Bench Press', 'sets': 4, 'restTime': 60},
        {'name': 'Deadlift', 'sets': 3, 'restTime': 120},
      ]
    },
    {
      'id': '2',
      'name': 'Upper Body Focus',
      'date': 'Feb 12, 2024',
      'exercises': [
        {'name': 'Pull Ups', 'sets': 4, 'restTime': 90},
        {'name': 'Shoulder Press', 'sets': 3, 'restTime': 60},
      ]
    },
  ];

  WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: JimTopBar(
        title: 'Workout History',
        actions: [
          JimTextButton(
            text: 'Filter',
            onPressed: () {/* Implement filtering */},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: workoutSessions.length,
        itemBuilder: (context, index) {
          final session = workoutSessions[index];
          return WorkoutHistoryCard(session: session);
        },
      ),
      bottomNavigationBar: JimNavBar(),
    );
  }
}

class WorkoutHistoryCard extends StatelessWidget {
  final Map<String, dynamic> session;

  const WorkoutHistoryCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WorkoutHistoryDetailScreen(),
          ),
        );
      },
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
                  child: Text(session['name'],
                      style: JimTextStyles.heading,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(session['date'],
                    style:
                        JimTextStyles.label.copyWith(color: JimColors.primary)),
              ],
            ),
            Text(session['description'] ?? 'No description available',
                style: JimTextStyles.subBody
                    .copyWith(color: JimColors.textSecondary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: JimSpacings.xs),
            Divider(
              color: JimColors.stroke,
              thickness: 1,
            ),
            Column(
              children: _buildExerciseList(),
            ),
            if ((session['exercises'] as List).length > 3)
              Padding(
                padding: const EdgeInsets.only(top: JimSpacings.s),
                child: Text(
                    '+ ${(session['exercises'] as List).length - 3} more exercises',
                    style: JimTextStyles.label
                        .copyWith(color: JimColors.textSecondary)),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildExerciseList() {
    final displayedExercises = (session['exercises'] as List).take(3).toList();
    return displayedExercises
        .map((exercise) => Padding(
              padding: const EdgeInsets.symmetric(vertical: JimSpacings.xs),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(exercise['name'],
                        style: JimTextStyles.subBody
                            .copyWith(color: JimColors.textPrimary)),
                  ),
                  Expanded(
                    child: Text('${exercise['sets']} sets',
                        style: JimTextStyles.label
                            .copyWith(color: JimColors.textSecondary)),
                  ),
                  Expanded(
                    child: Text('${exercise['restTime']}s',
                        style: JimTextStyles.label
                            .copyWith(color: JimColors.textSecondary)),
                  ),
                ],
              ),
            ))
        .toList();
  }
}
