import 'package:flutter/material.dart';

class ScreenDescription extends StatelessWidget {
  const ScreenDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Tell us how you feel before quitting.',
      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
      textAlign: TextAlign.center,
    );
  }
}
