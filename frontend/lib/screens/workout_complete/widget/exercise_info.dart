import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';

class ExerciseInfo extends StatelessWidget {
  final String date;
  final int time;

  const ExerciseInfo({super.key, required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.calendar_today, size: JimIconSizes.small),
        SizedBox(width: JimSpacings.xs),
        Text(date),
        SizedBox(width: JimSpacings.m),
        Icon(Icons.access_time, size: 16),
        SizedBox(width: JimSpacings.xs),
        Text('$time min'),
      ],
    );
  }
}
