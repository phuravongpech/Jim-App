import 'package:flutter/material.dart';

import '../../theme/theme.dart';

///
/// Text Button rendering for the whole application
///
class JimTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const JimTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Render the button
    return SizedBox(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: onPressed,
            child: Text(text,
                style: JimTextStyles.button
                    .copyWith(color: JimColors.primary, fontSize: 16))),
      ),
    );
  }
}
