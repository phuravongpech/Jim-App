import 'package:flutter/material.dart';
import 'package:frontend/models/exercise.dart';
import 'package:get/get.dart';

import '../../theme/theme.dart';
import '../../widgets/action/jim_button.dart';
import '../../widgets/navigation/jim_top_bar.dart';

class EditExerciseScreen extends StatefulWidget {
  const EditExerciseScreen({super.key, required Exercise exercise});

  @override
  State<EditExerciseScreen> createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildAddButton(),
    );
  }

  JimTopBar _buildAppBar() {
    return JimTopBar(
      title: 'Edit Exercise',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: JimColors.textPrimary),
        onPressed: () {
          Get.offNamed('/create-workout');
        },
      ),
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: JimSpacings.m, vertical: JimSpacings.s),
      child: JimButton(
        text: 'Add Exercises',
        onPressed: () {
          Get.toNamed('/select-exercises');
        },
        icon: Icons.add,
      ),
    );
  }
}