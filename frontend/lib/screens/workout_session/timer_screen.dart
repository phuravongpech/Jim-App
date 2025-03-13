import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:frontend/screens/workout_session/widgets/session_button.dart';
import 'package:frontend/theme/theme.dart';

class TimerScreen extends StatefulWidget {
  final int restTimeSecond;
  const TimerScreen({super.key, required this.restTimeSecond});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final CountDownController _controller = CountDownController();
  bool isPaused = false;
  //TODO implement setsCompleted and totalSets
  int setsCompleted = 2;
  int totalSets = 3;
  late int currentTimeInSeconds;

  void _addTime(int seconds) {
    setState(() {
      currentTimeInSeconds = (currentTimeInSeconds + seconds).clamp(1, 9999);
      _controller.restart(duration: currentTimeInSeconds);
    });
  }

  @override
  void initState() {
    super.initState();
    currentTimeInSeconds = widget.restTimeSecond;
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
            Text('Set $setsCompleted of $totalSets',
                style: JimTextStyles.heading.copyWith(fontSize: 40)),
            const SizedBox(height: JimSpacings.l),
            Text('Rest Time',
                style: JimTextStyles.title
                    .copyWith(color: JimColors.textSecondary)),
            const SizedBox(height: JimSpacings.xxl),
            CircularCountDownTimer(
              duration: widget.restTimeSecond,
              initialDuration: 0,
              controller: _controller,
              width: 280,
              height: 280,
              ringColor: JimColors.placeholder,
              fillColor: JimColors.primary,
              backgroundColor: JimColors.white,
              strokeWidth: 15.0,
              strokeCap: StrokeCap.round,
              textStyle: JimTextStyles.heading.copyWith(
                fontSize: 60,
              ),
              textFormat: CountdownTextFormat.MM_SS,
              isReverse: true,
              isReverseAnimation: true,
              isTimerTextShown: true,
              autoStart: true,
            ),
            const SizedBox(height: JimSpacings.xxl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: JimIconSizes.large),
                  onPressed: () => _addTime(-10),
                ),
                const SizedBox(width: JimSpacings.xxl),
                IconButton(
                  icon: Icon(isPaused ? Icons.play_arrow : Icons.pause,
                      size: 100),
                  onPressed: () {
                    setState(() {
                      isPaused = !isPaused;
                      isPaused ? _controller.pause() : _controller.resume();
                    });
                  },
                ),
                const SizedBox(width: JimSpacings.xxl),
                IconButton(
                  icon: const Icon(Icons.add, size: JimIconSizes.large),
                  onPressed: () => _addTime(10),
                ),
              ],
            ),
            const SizedBox(height: JimSpacings.xl),
            SessionButton(text: 'Next set', onPressed: () {})
          ],
        ),
      ),
    );
  }
}
