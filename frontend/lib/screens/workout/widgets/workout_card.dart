import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String description;
  final int exercisesCount;
  final VoidCallback? onEditPressed;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.description,
    required this.exercisesCount,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          bottom: JimSpacings.m, left: JimSpacings.xs, right: JimSpacings.xs),
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
      child: Padding(
        padding: const EdgeInsets.all(JimSpacings.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: JimTextStyles.heading.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (onEditPressed != null)
                  IconButton(
                    icon: const Icon(Icons.edit, size: JimIconSizes.small),
                    color: JimColors.primary,
                    onPressed: onEditPressed,
                    tooltip: 'Edit Workout',
                  ),
              ],
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
                  color: JimColors.primary,
                ),
                const SizedBox(width: JimSpacings.s),
                Text(
                  '$exercisesCount exercises',
                  style: JimTextStyles.subBody.copyWith(
                    color: JimColors.textSecondary,
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
