import 'package:flutter/material.dart';
import 'package:frontend/widgets/action/jim_button.dart';

class ActionButtons extends StatelessWidget {
  final List<String> selectedFeelings;

  const ActionButtons({super.key, required this.selectedFeelings});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: JimButton(
            text: 'Continue Workout',
            onPressed: () {},
            type: ButtonType.secondary,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: JimButton(
            text: 'Quit Workout',
            onPressed: selectedFeelings.isEmpty ? null : () {},
            type: ButtonType.primary,
          ),
        ),
      ],
    );
  }
}
