import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/action/jim_text_button.dart';

class ExerciseDetails extends StatelessWidget {
  final String name;
  final int setCount;
  final int setNumber;

  const ExerciseDetails({
    super.key,
    required this.name,
    required this.setCount,
    required this.setNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: JimTextStyles.title,
        ),
        const SizedBox(height: 4),
        setCount < setNumber
            ? JimTextButton(text: 'Enter', onPressed: (){})
            : Text(
                "All sets complete",
                style: JimTextStyles.body.copyWith(color: JimColors.primary),
              ),
      ],
    );
  }
}