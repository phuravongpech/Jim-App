import 'package:flutter/material.dart';
import 'feeling_button.dart';

class FeelingOptions extends StatelessWidget {
  final List<String> options;
  final List<String> selectedFeelings;
  final Function(String) onToggle;

  const FeelingOptions({
    super.key,
    required this.options,
    required this.selectedFeelings,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options
          .map((feeling) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: FeelingButton(
                  text: feeling,
                  isSelected: selectedFeelings.contains(feeling),
                  onPressed: () => onToggle(feeling),
                ),
              ))
          .toList(),
    );
  }
}
