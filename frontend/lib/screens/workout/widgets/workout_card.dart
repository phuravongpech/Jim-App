import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String description;
  final int exercisesCount;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.description,
    required this.exercisesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: JimSpacings.m),
      decoration: BoxDecoration(
        color: JimColors.backgroundAccent,
        borderRadius: BorderRadius.circular(JimSpacings.radius),
        border: Border.all(
          color: JimColors.stroke,
          width: 1, // Border width
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(JimSpacings.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: JimTextStyles.heading.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: JimSpacings.s),
            Text(
              description,
              style: JimTextStyles.subBody.copyWith(
                color: JimColors.textSecondary,
              ),
            ),
            const SizedBox(height: JimSpacings.l),
            Row(
              children: [
                const Icon(
                  Icons.fitness_center,
                  size: JimIconSizes.small,
                  color: JimColors.textPrimary,
                ),
                const SizedBox(width: JimSpacings.s),
                Text(
                  '$exercisesCount exercises',
                  style: JimTextStyles.subBody.copyWith(
                    color: JimColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}