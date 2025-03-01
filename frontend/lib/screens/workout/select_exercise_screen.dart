import 'package:flutter/material.dart';
import 'package:frontend/common/theme.dart';
import 'package:frontend/controller/select_exercise_controller.dart';
import 'package:frontend/screens/workout/widgets/select_exercise_card.dart';
import 'package:frontend/widgets/SearchExercises/custom_select_search.dart';
import 'package:get/get.dart';

import '../../models/exercise.dart';

class SelectExerciseScreen extends StatelessWidget {
  SelectExerciseScreen({super.key});

  final SelectExerciseController controller =
      Get.put(SelectExerciseController(), permanent: true);
  final TextEditingController _searchController = TextEditingController();

  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      controller.searchExercises(query); // Search exercises
    } else {
      controller.fetchExercises(reset: true); // Fetch all exercises
    }
  }

  void _onClearSearch() {
    _searchController.clear();
    controller.fetchExercises(
        reset: true); // Clear search and fetch all exercises
  }

  void _navigateToExerciseDetails(Exercise exercise) {
    Get.toNamed('/exercise-detail', arguments: exercise);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackground,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          CustomSelectSearch(
            searchController: _searchController,
            onClear: _onClearSearch,
            onSearchSubmitted: _onSearchSubmitted,
          ),
          const SizedBox(height: 16),
          _buildNumberSelectedExercises(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.exercises.isEmpty) {
                return const Center(
                  child: Text(
                    'No exercises found.',
                    style: TextStyle(
                      color: AppColor.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.exercises.length,
                itemBuilder: (context, index) {
                  final exercise = controller.exercises[index];
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
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: _buildDoneButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColor.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColor.black),
        onPressed: () {
          Get.back();
        },
      ),
      title: const Text(
        'Select Exercises',
        style: TextStyle(
          color: AppColor.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDoneButton() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ElevatedButton.icon(
        onPressed: () {
          Get.back(result: controller.selectedExercises.toList());
        },
        icon: const Icon(
          Icons.check,
          color: AppColor.white,
        ),
        label: const Text('Done'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildNumberSelectedExercises() {
    return Obx(() {
      final selectedCount = controller.selectedExercises.length;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$selectedCount ',
                    style: TextStyle(
                      color:
                          selectedCount > 0 ? AppColor.primary : AppColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: selectedCount == 1 || selectedCount == 0
                        ? 'exercise selected'
                        : 'exercises selected',
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (selectedCount > 0)
              TextButton(
                onPressed: () {
                  controller.clearSelectedExercises();
                },
                child: Text(
                  'Deselect All',
                  style: TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
