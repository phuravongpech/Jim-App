import 'package:flutter/material.dart';
import 'package:frontend/widgets/action/jim_button.dart';

class FeelingButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const FeelingButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return JimButton(
      text: text,
      onPressed: onPressed,
      type: isSelected ? ButtonType.primary : ButtonType.secondary,
      icon: isSelected ? Icons.check : null,
    );
  }
}
