import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/edit_exercise_controller.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/action/jim_button.dart';
import 'package:frontend/widgets/navigation/jim_top_bar.dart';
import 'package:get/get.dart';

class RestTimePicker extends StatelessWidget {
  final int initialRestTime;
  final int exerciseIndex;

  const RestTimePicker({
    super.key,
    required this.initialRestTime,
    required this.exerciseIndex,
  });

  void _onSelectedMinutesChanged(int value) {
    int totalSeconds = value * 60 + initialRestTime % 60;
    Get.find<EditExerciseController>().updateRestTime(exerciseIndex, totalSeconds);
  }

  void _onSelectedSecondsChanged(int value) {
    int totalSeconds = (initialRestTime ~/ 60) * 60 + value;
    Get.find<EditExerciseController>().updateRestTime(exerciseIndex, totalSeconds);
  }

  @override
  Widget build(BuildContext context) {
    final EditExerciseController controller =
        Get.find<EditExerciseController>();

    // Calculate initial minute and second values
    int initialMinutes = initialRestTime ~/ 60;
    int initialSeconds = initialRestTime % 60;

    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: JimTopBar(
        title: 'Rest Time',
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: JimColors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(JimSpacings.radius),
                ),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: JimColors.white,
                    borderRadius: BorderRadius.circular(JimSpacings.radius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(JimSpacings.l),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text('Minutes', style: JimTextStyles.body),
                            Text('Seconds', style: JimTextStyles.body),
                          ],
                        ),
                        const SizedBox(height: JimSpacings.s),
                        // Minutes and Seconds Pickers
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Minutes Picker
                            Container(
                              height: 150,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(JimSpacings.radius),
                              ),
                              child: CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                    initialItem: initialMinutes),
                                itemExtent: 40,
                                onSelectedItemChanged: _onSelectedMinutesChanged,
                                children: List<Widget>.generate(6, (index) {
                                  return Center(
                                    child: Text(
                                      index.toString().padLeft(2, '0'),
                                      style: JimTextStyles.heading.copyWith(
                                        fontSize: 24,
                                        color: JimColors.textPrimary,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const Text(
                              ':',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: JimColors.textPrimary,
                              ),
                            ),
                            // Seconds Picker
                            Container(
                              height: 150,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(JimSpacings.radius),
                              ),
                              child: CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                  initialItem: initialSeconds),
                                itemExtent: 40,
                                onSelectedItemChanged: _onSelectedSecondsChanged,
                                children: List<Widget>.generate(60, (index) {
                                  return Center(
                                    child: Text(
                                      index.toString().padLeft(2, '0'),
                                      style: JimTextStyles.heading.copyWith(
                                        fontSize: 24,
                                        color: JimColors.textPrimary,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: JimSpacings.l),
                        // Save Button
                        JimButton(
                          text: 'Save',
                          onPressed: () {
                            Get.back(result: controller.exercises[exerciseIndex].restTimeSecond);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}