import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';

class SetButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final double borderRadius;

  const SetButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.iconColor = JimColors.black,
    this.backgroundColor = JimColors.whiteGrey,
    this.size = 24,
    this.borderRadius = JimSpacings.radiusSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          color: iconColor,
          iconSize: size * 0.75,
        ),
      ],
    );
  }
}
