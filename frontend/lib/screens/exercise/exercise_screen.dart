import 'package:flutter/material.dart';
import 'package:frontend/controller/exercise_controller.dart';
import 'package:frontend/screens/exercise/widgets/exercise_card.dart';
import 'package:get/get.dart';

class ExerciseScreen extends StatelessWidget {
  ExerciseScreen({super.key});

  final exerciseController = Get.put(ExerciseController());
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              return ListView.builder(
                itemCount: exerciseController.exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exerciseController.exercises[index];
                  return ExerciseCard(exercise: exercise);
                },
              );
            }),
          ),
        ],
      ),
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
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search exercises...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                exerciseController.fetchExercises(); // Reset the list
              },
            ),
            prefixIcon: const Icon(Icons.search),
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              exerciseController.searchExercises(value);
            }
          },
        ),
      ),
    );
  }
}
