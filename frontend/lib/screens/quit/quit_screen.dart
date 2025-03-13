import 'package:flutter/material.dart';
import 'package:frontend/screens/quit/widget/action_buttons.dart';
import 'package:frontend/screens/quit/widget/feeling_options.dart';
import 'package:frontend/screens/quit/widget/screen_description.dart';
import 'package:frontend/screens/quit/widget/screen_title.dart';

class QuitWorkoutScreen extends StatefulWidget {
  const QuitWorkoutScreen({super.key});

  @override
  State<QuitWorkoutScreen> createState() => _QuitWorkoutScreenState();
}

class _QuitWorkoutScreenState extends State<QuitWorkoutScreen> {
  final List<String> _selectedFeelings = [];
  final List<String> _feelingOptions = [
    'Feeling Great',
    'It\'s Okay',
    'Too Tired',
    'Not Feeling Well',
    'Feeling Energetic',
    'Feeling Stressed',
  ];

  void _toggleFeeling(String feeling) {
    setState(() {
      _selectedFeelings.contains(feeling)
          ? _selectedFeelings.remove(feeling)
          : _selectedFeelings.add(feeling);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const ScreenTitle(),
              const SizedBox(height: 10),
              const ScreenDescription(),
              const SizedBox(height: 30),
              FeelingOptions(
                options: _feelingOptions,
                selectedFeelings: _selectedFeelings,
                onToggle: _toggleFeeling,
              ),
              const SizedBox(height: 40),
              ActionButtons(selectedFeelings: _selectedFeelings),
            ],
          ),
        ),
      ),
    );
  }
}
