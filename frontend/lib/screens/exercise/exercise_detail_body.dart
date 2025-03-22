import 'package:flutter/material.dart';
import 'package:frontend/controller/exercise_detail_controller.dart';
import 'package:frontend/theme/theme.dart';

class ExerciseDetailBody extends StatelessWidget {
  const ExerciseDetailBody({super.key, required this.controller});

  final ExerciseDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: JimSpacings.m), // Updated padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: JimSpacings.l),
          _buildExerciseHeader(),
          const SizedBox(height: JimSpacings.xl),
          _buildMuscleGroups(),
          const SizedBox(height: JimSpacings.xl),
          _buildEquipmentInfo(),
          const SizedBox(height: JimSpacings.xl),
          _buildInstructions(),
        ],
      ),
    );
  }

  Widget _buildExerciseHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.formattedName,
          style: JimTextStyles.heading.copyWith(
            color: JimColors.textPrimary,
          ),
        ),
        const SizedBox(height: JimSpacings.xs),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: JimSpacings.s, vertical: JimSpacings.xs),
          decoration: BoxDecoration(
            color: JimColors.primary,
            borderRadius: BorderRadius.circular(JimSpacings.radiusSmall),
          ),
          child: Text(
            controller.formattedBodyPart,
            style: JimTextStyles.body.copyWith(
              color: JimColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMuscleGroups() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Muscle Groups',
          style: JimTextStyles.heading.copyWith(
            color: JimColors.textPrimary,
          ),
        ),
        const SizedBox(height: JimSpacings.m),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: JimColors.white,
            borderRadius: BorderRadius.circular(JimSpacings.radius),
          ),
          child: Column(
            children: [
              _buildMuscleItem(
                title: 'Primary Target',
                muscle: controller.exercise.target,
                icon: Icons.track_changes,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMuscleItem({
    required String title,
    required String muscle,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(JimSpacings.s),
          decoration: BoxDecoration(
            color: JimColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: JimColors.black, size: JimIconSizes.medium),
        ),
        const SizedBox(width: JimSpacings.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: JimTextStyles.body.copyWith(
                  color: JimColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                muscle,
                style: JimTextStyles.body.copyWith(
                  color: JimColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEquipmentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Equipment',
          style: JimTextStyles.heading.copyWith(
            color: JimColors.textPrimary,
          ),
        ),
        const SizedBox(height: JimSpacings.m),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: JimColors.white,
            borderRadius: BorderRadius.circular(JimSpacings.radius),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(JimSpacings.s),
                decoration: BoxDecoration(
                  color: JimColors.primary,
                  borderRadius: BorderRadius.circular(JimSpacings.radius),
                ),
                child: const Icon(
                  Icons.fitness_center,
                  color: JimColors.black,
                  size: 24,
                ),
              ),
              const SizedBox(width: JimSpacings.m),
              Text(
                controller.formattedEquipment,
                style: JimTextStyles.body.copyWith(
                  color: JimColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructions',
          style: JimTextStyles.heading.copyWith(
            color: JimColors.textPrimary,
          ),
        ),
        const SizedBox(height: JimSpacings.m),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: JimColors.white,
            borderRadius: BorderRadius.circular(JimSpacings.radius),
          ),
          child: Column(
            children: controller.instructions.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final instruction = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: JimSpacings.m),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: JimColors.primary,
                        borderRadius:
                            BorderRadius.circular(JimSpacings.radiusSmall),
                      ),
                      child: Center(
                        child: Text(
                          '$index',
                          style: JimTextStyles.body.copyWith(
                            color: JimColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: JimSpacings.s),
                    Expanded(
                      child: Text(
                        instruction,
                        style: JimTextStyles.body.copyWith(
                          color: JimColors.textPrimary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
