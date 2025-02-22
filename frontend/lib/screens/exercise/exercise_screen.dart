import 'package:flutter/material.dart';
import 'package:frontend/common/theme.dart';
import 'package:frontend/controller/exercise_controller.dart';
import 'package:frontend/screens/exercise/widgets/exercise_card.dart';
import 'package:frontend/widgets/ButtomNavigationBar/custom_bottom_navbar.dart';
import 'package:get/get.dart';

class ExerciseScreen extends StatelessWidget {
  ExerciseScreen({super.key});

  final ExerciseController exerciseController = Get.put(ExerciseController());
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackground,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchExercise(),
          const SizedBox(height: 16),
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
      title: const Text(
        'EXERCISE',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _buildSearchExercise() {
    return Card(
      color: AppColor.white,
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
