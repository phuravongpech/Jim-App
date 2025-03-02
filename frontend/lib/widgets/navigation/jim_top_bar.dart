import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';

class JimTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;

  const JimTopBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: JimColors.backgroundAccent,
      elevation: 0,
      centerTitle: centerTitle,
      leading: leading,
      title: Text(title, style: JimTextStyles.heading),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
