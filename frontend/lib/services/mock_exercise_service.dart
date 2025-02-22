import 'package:frontend/models/exercise.dart';

class MockExerciseService {
  Future<List<Exercise>> getExercises({
    required String bodyPart,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
      10,
      (index) => Exercise(
        id: '${bodyPart}_${index + 1}',
        name: '$bodyPart Exercise ${index + 1}',
        bodyPart: bodyPart,
        equipment: 'Dumbbell',
        target: 'Target Muscle ${index + 1}',
        gifUrl: 'https://example.com/exercise${index + 1}.gif',
      ),
    );
  }

  Future<List<Exercise>> searchExercises({required String query}) async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
      5,
      (index) => Exercise(
        id: '${query}_${index + 1}',
        name: 'Search Result $query ${index + 1}',
        bodyPart: 'Chest',
        equipment: 'Barbell',
        target: 'Pectoral ${index + 1}',
        gifUrl: 'https://example.com/search${index + 1}.gif',
      ),
    );
  }
}
