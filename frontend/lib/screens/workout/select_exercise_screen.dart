import 'package:flutter/material.dart';
import 'package:frontend/controller/select_exercise_controller.dart';
import 'package:frontend/screens/workout/widgets/select_exercise_card.dart';
import 'package:frontend/widgets/inputs/custom_select_search.dart';
import 'package:frontend/widgets/navigation/jim_top_bar.dart';
import 'package:get/get.dart';

import '../../models/exercise.dart';
import '../../theme/theme.dart';
import '../../widgets/action/jim_button.dart';
import '../../widgets/action/jim_icon_button.dart';
import '../../widgets/action/jim_text_button.dart';
import '../../widgets/display/jim_list_view.dart';

class SelectExerciseScreen extends StatelessWidget {
  SelectExerciseScreen({super.key});

  final SelectExerciseController controller =
      Get.put(SelectExerciseController(), permanent: true);
  final TextEditingController _searchController = TextEditingController();

  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      controller.searchExercises(query); // Search exercises
      // } else {
      //   controller.fetchExercises(reset: true); // Fetch all exercises
    }
  }

  void _onClearSearch() {
    _searchController.clear();
    // controller.fetchExercises(
    //     reset: true); // Clear search and fetch all exercises
  }

  void _navigateToExerciseDetails(Exercise exercise) {
    Get.toNamed('/exercise-detail', arguments: exercise);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: JimTopBar(
        title: 'Select Exercises',
        centerTitle: true,
        leading: JimIconButton(
          icon: Icons.arrow_back,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          CustomSelectSearch(
            searchController: _searchController,
            onClear: _onClearSearch,
            onSearchSubmitted: _onSearchSubmitted,
          ),
          const SizedBox(height: JimSpacings.m),
          _buildNumberSelectedExercises(),
          Expanded(
            child: JimListView(
              items: controller.exercises,
              isLoading: controller.isLoading,
              emptyMessage: 'No exercises found.',
              itemBuilder: (exercise) {
                return Obx(() {
                  final isSelected =
                      controller.selectedExercises.contains(exercise.id);
                  return SelectExerciseCard(
                    exercise: exercise,
                    isSelected: isSelected,
                    onSelected: (isSelected) {
                      controller.toggleExerciseSelection(exercise.id);
                    },
                    onTap: () => _navigateToExerciseDetails(exercise),
                  );
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildDoneButton(),
    );
  }

  Widget _buildDoneButton() {
    return Padding(
      padding: const EdgeInsets.all(JimSpacings.m),
      child: JimButton(
        text: 'Done',
        onPressed: () {
          final selectedExercises = controller.selectedExercises.map((id) {
            return controller.allExercises.firstWhere(
              (exercise) => exercise.id == id,
            );
          }).toList();
          Get.back(result: selectedExercises);
        },
        type: ButtonType.primary,
        icon: Icons.check,
      ),
    );
  }

  Widget _buildNumberSelectedExercises() {
    return Obx(() {
      final selectedCount = controller.selectedExercises.length;
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: JimSpacings.m, vertical: JimSpacings.s),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$selectedCount ',
                    style: JimTextStyles.body.copyWith(
                      color: selectedCount > 0
                          ? JimColors.primary
                          : JimColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: selectedCount == 1 || selectedCount == 0
                        ? 'exercise selected'
                        : 'exercises selected',
                    style: JimTextStyles.body.copyWith(
                      color: JimColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (selectedCount > 0)
              JimTextButton(
                text: 'Deselect All',
                onPressed: () {
                  controller.clearSelectedExercises();
                },
              ),
          ],
        ),
      );
    });
  }
}
