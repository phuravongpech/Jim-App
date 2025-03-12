import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';

class ExerciseSet extends StatelessWidget {
  final Map<String, dynamic> exercise;

  const ExerciseSet({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exercise['name'],
          style: JimTextStyles.title,
        ),
        SizedBox(height: JimSpacings.xs),
        ExerciseSetTable(sets: exercise['sets']),
        SizedBox(height: JimSpacings.m),
      ],
    );
  }
}

class ExerciseSetTable extends StatelessWidget {
  final List<List<int>> sets;

  const ExerciseSetTable({super.key, required this.sets});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          children: [
            _buildTableCell('Set'),
            _buildTableCell('Weight (kg)'),
            _buildTableCell('Reps'),
            _buildTableCell('Status'),
          ],
        ),
        for (var set in sets) ExerciseSetRow(set: set),
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return TableCell(
      child: Padding(
        padding: EdgeInsets.all(JimSpacings.xs),
        child: Text(text),
      ),
    );
  }
}

class ExerciseSetRow extends TableRow {
  ExerciseSetRow({required List<int> set})
      : super(
          children: [
            _buildTableCell(set[0].toString()),
            _buildTableCell(set[1] > 0 ? '${set[1]}' : '-'),
            _buildTableCell(set[2].toString()),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(JimSpacings.xs),
                child: _getStatusIcon(weight: set[1], reps: set[2]),
              ),
            ),
          ],
        );

  static Widget _buildTableCell(String text) {
    return TableCell(
      child: Padding(
        padding: EdgeInsets.all(JimSpacings.xs),
        child: Text(text),
      ),
    );
  }

  static Widget _getStatusIcon({required int weight, required int reps}) {
    return Icon(
      reps > 0 ? Icons.check_circle : Icons.cancel,
      color: reps > 0 ? JimColors.primary : Colors.red,
    );
  }
}
