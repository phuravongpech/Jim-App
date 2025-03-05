import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/exercise.dart';
import 'package:frontend/theme/theme.dart';

class SelectExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;
  final VoidCallback onTap;

  const SelectExerciseCard({
    super.key,
    required this.exercise,
    required this.isSelected,
    required this.onSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    print(
        'Building SelectExerciseCard for ${exercise.name}, isSelected: $isSelected'); // Debugging
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: JimSpacings.xs, vertical: JimSpacings.s),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
        color: Colors.white,
        child: Row(
          children: [
            // Custom Radio Button (Checkmark)
            GestureDetector(
              onTap: () => onSelected(!isSelected),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? JimColors.primary : JimColors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? JimColors.primary
                          : JimColors.textSecondary,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 16,
                          color: JimColors.white,
                        )
                      : null,
                ),
              ),
            ),

            // Exercise Details and Image
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: JimSpacings.s, vertical: JimSpacings.s),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Exercise Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: exercise.gifUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 60,
                          height: 60,
                          color: JimColors.white,
                          child: const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  JimColors.placeholder),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 60,
                          height: 60,
                          color: JimColors.stroke,
                          child:
                              const Icon(Icons.error, color: JimColors.error),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Exercise Name
                          Text(
                            exercise.name
                                .split(' ')
                                .map((word) =>
                                    word[0].toUpperCase() + word.substring(1))
                                .join(' '),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: JimColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Target and Equipment
                          Text(
                            "${exercise.target}, ${exercise.equipment}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: JimColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}