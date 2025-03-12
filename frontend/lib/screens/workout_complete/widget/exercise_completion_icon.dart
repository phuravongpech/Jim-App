import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';

class ExerciseCompletionIcon extends StatelessWidget {
  const ExerciseCompletionIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: JimColors.primary, width: 2),
        ),
        child: Center(
          child: Icon(Icons.check, size: JimIconSizes.large, color: JimColors.primary),
        ),
      ),
    );
  }
}
