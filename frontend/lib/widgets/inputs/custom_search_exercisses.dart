import 'package:flutter/material.dart';
import 'package:frontend/controller/exercise_controller.dart';
import 'package:frontend/theme/theme.dart';
import 'package:get/get.dart';

class CustomSearchExercisses extends StatelessWidget {
  CustomSearchExercisses({super.key});

  final ExerciseController exerciseController = Get.put(ExerciseController());
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: JimColors.white,
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(JimSpacings.radiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: JimSpacings.xs, vertical: JimSpacings.xs),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search exercises...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                exerciseController.fetchExercises(reset: true);
              },
            ),
            prefixIcon: const Icon(Icons.search),
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              exerciseController.searchExercises(value);
            } else {
              exerciseController.fetchExercises(reset: true);
            }
          },
        ),
      ),
    );
  }
}
