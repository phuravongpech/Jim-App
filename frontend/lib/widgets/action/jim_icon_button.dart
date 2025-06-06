import 'package:flutter/material.dart';

import '../../theme/theme.dart';

///
/// Icon Button rendering for the whole application
///
class JimIconButton extends StatelessWidget {
  final Color color;
  final IconData? icon;
  final VoidCallback? onPressed;

  const JimIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color = JimColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: JimSpacings.m),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onPressed,
          child: Icon(
            icon,
            size: JimIconSizes.medium,
            color: color,
          ),
        ),
      ),
    );
  }
}
