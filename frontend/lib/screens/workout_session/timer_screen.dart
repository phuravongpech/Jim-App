import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:frontend/services/workout_session_service.dart';
import 'package:frontend/controller/workout_session_controller.dart';
import 'package:frontend/screens/workout_session/widgets/set_log_button.dart';
import 'package:frontend/theme/theme.dart';
import 'package:get/get.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final _service = WorkoutSessionService.instance;
  final _sessionController = Get.find<WorkoutSessionController>();
  final CountDownController _countDownController = CountDownController();

  final isPaused = false.obs;
  final currentTimeInSeconds = 0.obs;

  @override
  void initState() {
    super.initState();
    currentTimeInSeconds.value = _service.currentExercise?.restTimeSecond ?? 90;
  }

  void _addTime(int seconds) {
    currentTimeInSeconds.value =
        (currentTimeInSeconds.value + seconds).clamp(1, 9999);
    _countDownController.restart(duration: currentTimeInSeconds.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      body: Padding(
        padding: const EdgeInsets.all(JimSpacings.m),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Rest Time',
                style: JimTextStyles.heading.copyWith(fontSize: 40)),
            const SizedBox(height: JimSpacings.l),
            Obx(() {
              final currentSet = _service.currentSetIndex.value + 1;
              final totalSets = _service.currentExercise?.setCount ?? 0;

              return Text('Set $currentSet of $totalSets',
                  style: JimTextStyles.title
                      .copyWith(color: JimColors.textSecondary));
            }),
            const SizedBox(height: JimSpacings.xxl),
            Obx(() => CircularCountDownTimer(
                  duration: currentTimeInSeconds.value,
                  initialDuration: 0,
                  controller: _countDownController,
                  width: 280,
                  height: 280,
                  ringColor: JimColors.placeholder,
                  fillColor: JimColors.primary,
                  backgroundColor: JimColors.white,
                  strokeWidth: 15.0,
                  strokeCap: StrokeCap.round,
                  textStyle: JimTextStyles.heading.copyWith(fontSize: 60),
                  textFormat: CountdownTextFormat.MM_SS,
                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: true,
                  autoStart: true,
                  onComplete: _sessionController.handleRestComplete,
                )),
            const SizedBox(height: JimSpacings.xxl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: JimIconSizes.large),
                  onPressed: () => _addTime(-10),
                ),
                const SizedBox(width: JimSpacings.xxl),
                Obx(() => IconButton(
                      icon: Icon(
                          isPaused.value ? Icons.play_arrow : Icons.pause,
                          size: 100),
                      onPressed: () {
                        isPaused.value = !isPaused.value;
                        isPaused.value
                            ? _countDownController.pause()
                            : _countDownController.resume();
                      },
                    )),
                const SizedBox(width: JimSpacings.xxl),
                IconButton(
                  icon: const Icon(Icons.add, size: JimIconSizes.large),
                  onPressed: () => _addTime(10),
                ),
              ],
            ),
            const SizedBox(height: JimSpacings.xl),
            SetLogButton(
              text: 'Next set',
              onPressed: _sessionController.handleRestComplete,
            ),
          ],
        ),
      ),
    );
  }
}
