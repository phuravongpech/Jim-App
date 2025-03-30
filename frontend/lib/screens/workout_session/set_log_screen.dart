import 'package:flutter/material.dart';
import 'package:frontend/services/workout_session_service.dart';
import 'package:frontend/controller/workout_session_controller.dart';
import 'package:frontend/screens/workout_session/widgets/set_log_button.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:frontend/theme/theme.dart';
import 'package:flutter/services.dart';

class SetLogScreen extends GetView<WorkoutSessionController> {
  SetLogScreen({super.key});

  final _service = WorkoutSessionService.instance;
  final weightController = TextEditingController(text: '0');
  final repsController = TextEditingController(text: '0');
  final repsError = false.obs;

  void _onLogSet() {
    final reps = int.tryParse(repsController.text) ?? 0;
    final weight = double.tryParse(weightController.text) ?? 0;

    if (reps <= 0) {
      repsError.value = true;
      return;
    }
    repsError.value = false;
    controller.logSetAndNavigate(reps, weight);
  }

  @override
  Widget build(BuildContext context) {
    final currentExercise = _service.exercise;
    final exerciseName = currentExercise?.name ?? 'unknown';
    final exerciseGifUrl =
        currentExercise?.gifUrl ?? 'https://picsum.photos/250?image=10';

    return Scaffold(
        backgroundColor: JimColors.backgroundAccent,
        appBar: AppBar(
          backgroundColor: JimColors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: JimColors.textPrimary),
            onPressed: () => Get.back(),
          ),
          title: Text(exerciseName, style: JimTextStyles.heading),
        ),
        body: Padding(
          padding: EdgeInsets.all(JimSpacings.l),
          child: Column(
            children: [
              Obx(() {
                final currentSet = _service.currentSetIndex.value + 1;
                final totalSets = _service.currentExercise?.setCount ?? 0;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Set $currentSet of $totalSets',
                        style: JimTextStyles.subBody),
                    SizedBox(height: JimSpacings.s),
                    LinearPercentIndicator(
                      width:
                          MediaQuery.of(context).size.width - 2 * JimSpacings.l,
                      lineHeight: 10.0,
                      percent: currentSet / (totalSets == 0 ? 1 : totalSets),
                      backgroundColor: JimColors.whiteGrey,
                      progressColor: JimColors.primary,
                      barRadius: Radius.circular(JimSpacings.radius),
                      animation: true,
                      animationDuration: 500,
                    ),
                  ],
                );
              }),
              SizedBox(height: JimSpacings.l),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: JimColors.whiteGrey,
                  borderRadius: BorderRadius.circular(JimSpacings.radius),
                  border: Border.all(color: JimColors.primary),
                ),
                padding: EdgeInsets.all(JimSpacings.l),
                child: Image.network(
                  exerciseGifUrl,
                  fit: BoxFit.cover,
                  width: 200,
                  height: 350,
                ),
              ),
              SizedBox(height: JimSpacings.xl),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      'Weight (kg)',
                      weightController,
                      showError: false,
                      maxLength: 3,
                    ),
                  ),
                  SizedBox(width: JimSpacings.m),
                  Expanded(
                    child: Obx(() => _buildInputField(
                          'Reps',
                          repsController,
                          showError: repsError.value,
                          maxLength: 2,
                        )),
                  ),
                ],
              ),
              Spacer(),
              SetLogButton(text: "Next Set", onPressed: _onLogSet),
            ],
          ),
        ));
  }
}

Widget _buildInputField(
  String label,
  TextEditingController controller, {
  required bool showError,
  required int maxLength,
}) {
  return Container(
    decoration: BoxDecoration(
      color: JimColors.white,
      borderRadius: BorderRadius.circular(JimSpacings.radius),
      border: Border.all(
        color: showError ? Colors.red : JimColors.primary,
        width: 2,
      ),
    ),
    padding: EdgeInsets.symmetric(vertical: JimSpacings.m),
    child: Column(
      children: [
        Text(label, style: JimTextStyles.title),
        SizedBox(height: JimSpacings.s),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: JimTextStyles.heading.copyWith(fontSize: 30),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '0',
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(maxLength),
          ],
          onTap: () {
            if (controller.text == "0") {
              controller.clear();
            }
          },
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Reps cannot be 0',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    ),
  );
}
