import 'package:flutter/material.dart';
import 'package:frontend/controller/exercise_controller.dart';
import 'package:frontend/screens/exercise/widgets/exercise_card.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/navigation/custom_bottom_navbar.dart';
import 'package:frontend/widgets/inputs/custom_search_exercisses.dart';
import 'package:frontend/widgets/navigation/jim_top_bar.dart';
import 'package:get/get.dart';

import '../../controller/select_exercise_controller.dart';
import '../../widgets/display/jim_list_view.dart';

class ExerciseScreen extends StatelessWidget {
  ExerciseScreen({super.key});

  final ExerciseController exerciseController = Get.put(ExerciseController());
  final SelectExerciseController controller =
      Get.put(SelectExerciseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: JimTopBar(title: "Exercises"),
      body: Column(
        children: [
          // Search bar
          CustomSearchExercisses(),

          const SizedBox(height: JimSpacings.m),

          Expanded(
            child: JimListView(
              items: exerciseController.exercises,
              isLoading: exerciseController.isLoading,
              emptyMessage: "No exercises found.",
              itemBuilder: (exercise) => ExerciseCard(exercise: exercise),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
