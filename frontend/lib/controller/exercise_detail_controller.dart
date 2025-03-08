import 'package:frontend/models/exercise.dart';
import 'package:get/get.dart';

class ExerciseDetailController extends GetxController {
  final Exercise exercise;

  ExerciseDetailController(this.exercise);

  /// Get the formatted name of the exercise
  String get formattedName => exercise.name
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');

  /// Get the formatted body part of the exercise
  String get formattedBodyPart => exercise.bodyPart.toUpperCase();

  /// Get the formatted equipment of the exercise
  String get formattedEquipment => exercise.equipment
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');

  /// Get the formatted target of the exercise
  String get formattedTarget => exercise.target
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
  /// Get the instructions of the exercise    
  List<String> get instructions => exercise.instructions ?? [];
}
