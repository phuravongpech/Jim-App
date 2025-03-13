import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class SessionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const SessionButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: JimColors.primary,
          foregroundColor: JimColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(JimSpacings.radius),
          ),
        ),
        child: Text('Next Set', style: JimTextStyles.button),
      ),
    );
  }
}
