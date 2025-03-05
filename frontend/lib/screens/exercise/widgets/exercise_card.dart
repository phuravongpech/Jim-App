import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/theme/theme.dart';
import 'package:get/get.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/exercise-detail', arguments: exercise);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
            horizontal: JimSpacings.m, vertical: JimSpacings.s),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(JimSpacings.radius),
        ),
        elevation: 2,
        color: JimColors.primary.withOpacity(0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'exercise-${exercise.id}',
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(JimSpacings.radius),
                  topRight: Radius.circular(JimSpacings.radius),
                ),
                child: CachedNetworkImage(
                  imageUrl: exercise.gifUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 200,
                    color: JimColors.white,
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            JimColors.placeholder),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 200,
                    color: JimColors.backgroundAccent,
                    child: const Icon(Icons.error, color: JimColors.error),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: JimSpacings.l,
                  top: JimSpacings.s,
                  bottom: JimSpacings.s),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Exercise Name
                  Text(
                    exercise.name
                        .split(' ')
                        .map(
                            (word) => word[0].toUpperCase() + word.substring(1))
                        .join(' '),
                    style: JimTextStyles.heading.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: JimColors.textPrimary,
                    ),
                  ),
                  // Target and Secondary Muscles
                  Text(
                    "${exercise.target}${exercise.secondaryMuscles != null && exercise.secondaryMuscles!.isNotEmpty ? ', ${exercise.secondaryMuscles!.join(', ')}' : ''}",
                    style: JimTextStyles.subBody.copyWith(
                      fontSize: 14,
                      color: JimColors.textSecondary,
                    ),
                  ),
                  // Equipment
                  Text(
                    exercise.equipment,
                    style: JimTextStyles.subBody.copyWith(
                      fontSize: 12,
                      color: JimColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}