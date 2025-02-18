import 'package:frontend/models/exercise.dart';
import 'package:get/get.dart';

class ExerciseDetailController extends GetxController {
  final Exercise exercise;

  ExerciseDetailController(this.exercise);

  bool get hasSecondaryMuscles =>
      exercise.secondaryMuscles != null &&
      exercise.secondaryMuscles!.isNotEmpty;

  String get formattedName => exercise.name
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');

  String get formattedBodyPart => exercise.bodyPart.toUpperCase();

  String get formattedEquipment => exercise.equipment
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');

  List<String> get instructions => exercise.instructions ?? [];
}
