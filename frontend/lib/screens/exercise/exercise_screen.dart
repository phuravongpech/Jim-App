import 'package:flutter/material.dart';
import 'package:frontend/controller/exercise_controller.dart';
import 'package:frontend/screens/exercise/widgets/exercise_card.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/ButtomNavigationBar/custom_bottom_navbar.dart';
import 'package:frontend/widgets/SearchExercises/custom_search_exercisses.dart';
import 'package:get/get.dart';

import '../../controller/select_exercise_controller.dart';

class ExerciseScreen extends StatelessWidget {
  ExerciseScreen({super.key});

  final ExerciseController exerciseController = Get.put(ExerciseController());
  final SelectExerciseController controller =
      Get.put(SelectExerciseController());

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Search bar
          CustomSearchExercisses(),

          const SizedBox(height: JimSpacings.m),

          Expanded(
            child: Obx(() {
              if (exerciseController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (exerciseController.exercises.isEmpty) {
                return const Center(child: Text('No exercises found.'));
              }

              final exercisesList = exerciseController.exercises.toList();
              return ListView.builder(
                itemCount: exercisesList.length,
                itemBuilder: (context, index) {
                  final exercise = exercisesList[index];
                  return ExerciseCard(exercise: exercise);
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('EXERCISE', style: JimTextStyles.body
          // TextStyle(
          //   fontWeight: FontWeight.bold,
          //   fontSize: 24,
          // ),
          ),
    );
  }
}
