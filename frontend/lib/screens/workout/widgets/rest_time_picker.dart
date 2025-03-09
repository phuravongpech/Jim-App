import 'package:flutter/material.dart';
import 'package:frontend/controller/edit_exercise_controller.dart';
import 'package:get/get.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:frontend/theme/theme.dart'; // Import your theme file
import 'package:frontend/widgets/navigation/jim_top_bar.dart'; // Import JimTopBar
import 'package:frontend/widgets/action/jim_icon_button.dart'; // Import JimIconButton

class RestTimePicker extends StatefulWidget {
  final int initialRestTime;
  final int exerciseIndex;

  const RestTimePicker({
    super.key,
    required this.initialRestTime,
    required this.exerciseIndex,
  });

  @override
  State<RestTimePicker> createState() => _RestTimePickerState();
}

class _RestTimePickerState extends State<RestTimePicker> {
  @override
  Widget build(BuildContext context) {
    final EditExerciseController controller = Get.find<EditExerciseController>();

    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: JimTopBar(
        title: 'Set Rest Time',
        leading: JimIconButton(
          icon: Icons.arrow_back,
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          JimIconButton(
            icon: Icons.check,
            onPressed: () {
              Get.back(result: controller.exercises[widget.exerciseIndex].restTimeSecond);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Duration Picker
            GetBuilder<EditExerciseController>(
              builder: (controller) {
                return FadeTransition(
                  opacity: controller.animation,
                  child: ScaleTransition(
                    scale: controller.animation,
                    child: DurationPicker(
                      duration: Duration(
                        seconds: controller.exercises[widget.exerciseIndex].restTimeSecond,
                      ),
                      onChange: (newDuration) {
                        controller.updateRestTime(
                          widget.exerciseIndex,
                          newDuration.inSeconds,
                        );
                      },
                      snapToMins: 1.0, // Snap to 1-minute intervals
                      baseUnit: BaseUnit.second, // Allow picking seconds
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: JimSpacings.m),
            // Display selected rest time
            Obx(() {
              return Text(
                'Selected Rest Time: ${controller.exercises[widget.exerciseIndex].restTimeSecond} seconds',
                style: JimTextStyles.body.copyWith(color: JimColors.textPrimary),
              );
            }),
          ],
        ),
      ),
    );
  }
}