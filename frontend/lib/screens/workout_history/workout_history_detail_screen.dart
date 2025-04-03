import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';
import 'package:get/get.dart';

class WorkoutHistoryDetailScreen extends StatelessWidget {
  final Map<String, dynamic> session = {
    'id': Get.arguments,
    'name': 'Full Body Strength',
    'date': 'Feb 15, 2024',
    'exercises': [
      {
        'name': 'Barbell Squats',
        'sets': [
          {'weight': 60, 'reps': 8, 'restTime': 90},
          {'weight': 65, 'reps': 8, 'restTime': 90},
          {'weight': 70, 'reps': 6, 'restTime': 90},
        ]
      },
      {
        'name': 'Bench Press',
        'sets': [
          {'weight': 80, 'reps': 5, 'restTime': 120},
          {'weight': 85, 'reps': 4, 'restTime': 120},
        ]
      },
    ]
  };

  WorkoutHistoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: AppBar(
        title: Text(session['name'], style: JimTextStyles.heading),
        centerTitle: true,
        backgroundColor: JimColors.white,
        elevation: 2,
        shadowColor: JimColors.whiteGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(JimSpacings.m),
        child: Column(
          children: [
            _buildSessionCard(),
            const SizedBox(height: JimSpacings.xl),
            ..._buildExerciseCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionCard() {
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
      padding: const EdgeInsets.all(JimSpacings.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem(Icons.calendar_today, session['date']),
              _buildInfoItem(
                  Icons.list_alt, '${session['exercises'].length} exercises'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        const SizedBox(width: JimSpacings.m),
        Icon(icon, size: JimIconSizes.small, color: JimColors.primary),
        const SizedBox(width: JimSpacings.xs),
        Text(text, style: JimTextStyles.body),
        const SizedBox(width: JimSpacings.m),
      ],
    );
  }

  List<Widget> _buildExerciseCards() {
    return (session['exercises'] as List)
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
              padding: const EdgeInsets.all(JimSpacings.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exercise['name'], style: JimTextStyles.title),
                  const SizedBox(height: JimSpacings.m),
                  _buildSetTable(exercise['sets']),
                ],
              ),
            ))
        .toList();
  }

  Widget _buildSetTable(List<dynamic> sets) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(3),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: JimColors.stroke))),
          children: [
            _buildTableHeader('Set'),
            _buildTableHeader('Weight (kg)'),
            _buildTableHeader('Reps'),
            _buildTableHeader('Rest Time'),
          ],
        ),
        ...sets.map((set) => TableRow(
              children: [
                _buildTableCell('${sets.indexOf(set) + 1}'),
                _buildTableCell(set['weight'].toString()),
                _buildTableCell(set['reps'].toString()),
                _buildTableCell('${set['restTime']}s'),
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
