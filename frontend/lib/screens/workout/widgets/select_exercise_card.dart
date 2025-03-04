import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/theme.dart';
import 'package:frontend/models/exercise.dart';

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
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColor.primary : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppColor.primary
                          : AppColor.textSecondary,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 16,
                          color: AppColor.white,
                        )
                      : null,
                ),
              ),
            ),

            // Exercise Details and Image
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
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
                          color: AppColor.white,
                          child: const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.accent),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[300],
                          child:
                              const Icon(Icons.error, color: AppColor.warning),
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
                              color: AppColor.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Target and Equipment
                          Text(
                            "${exercise.target}, ${exercise.equipment}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColor.textSecondary,
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
