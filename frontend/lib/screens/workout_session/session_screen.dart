import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:frontend/theme/theme.dart';
import 'package:flutter/services.dart'; // Import for TextInputFormatter

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  int seconds = 24;
  bool isTimerRunning = true;

  //TODO currentSet and totalSets should be passed from the previous screen
  int currentSet = 1;
  int totalSets = 3;
  final TextEditingController weightController =
      TextEditingController(text: '0');
  final TextEditingController repsController = TextEditingController(text: '0');
  bool _repsError = false; // Add error flag

  void nextSet() {
    //TODO need to do 
    setState(() {
      _repsError =
          repsController.text.isEmpty || int.tryParse(repsController.text) == 0;
    });

    if (!_repsError && currentSet < totalSets) {
      setState(() {
        currentSet++;
        seconds = 24;
      });
    }
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JimColors.backgroundAccent,
      appBar: AppBar(
        backgroundColor: JimColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: JimColors.textPrimary),
          onPressed: () {},
        ),
        title: Text(
          'Squats',
          style: JimTextStyles.heading,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(JimSpacings.l),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Set $currentSet of $totalSets',
                      style: JimTextStyles.subBody),
                  SizedBox(height: JimSpacings.s),
                  LinearPercentIndicator(
                    width:
                        MediaQuery.of(context).size.width - 2 * JimSpacings.l,
                    lineHeight: 10.0,
                    percent: currentSet / totalSets,
                    backgroundColor: JimColors.whiteGrey,
                    progressColor: JimColors.primary,
                    barRadius: Radius.circular(JimSpacings.radius),
                    animation: true,
                    animationDuration: 500,
                  ),
                ],
              ),
              SizedBox(height: JimSpacings.l),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: JimColors.whiteGrey,
                  borderRadius: BorderRadius.circular(JimSpacings.radius),
                  border: Border.all(color: JimColors.primary),
                ),
                padding: EdgeInsets.all(JimSpacings.l),
                child: Image.network('https://picsum.photos/250?image=10',
                    fit: BoxFit.cover, width: 350, height: 350),
              ),
              SizedBox(height: JimSpacings.xl),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                        'Weight (kg)', weightController, false),
                  ),
                  SizedBox(width: JimSpacings.m),
                  Expanded(
                    child: _buildInputField(
                        'Reps', repsController, true), // Reps only numbers
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: nextSet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: JimColors.primary,
                    foregroundColor: JimColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(JimSpacings.radius),
                    ),
                  ),
                  child: Text('Next Set', style: JimTextStyles.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, TextEditingController controller, bool isReps) {
    //bool isReps is for checking if the input field is for reps, because if its reps, it cant be 0, but weight can
    return Container(
      decoration: BoxDecoration(
        color: JimColors.white,
        borderRadius: BorderRadius.circular(JimSpacings.radius),
        border: Border.all(
          color: isReps && _repsError
              ? Colors.red
              : JimColors.primary, // Red border if reps error
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
              decoration: InputDecoration(border: InputBorder.none),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ]),
          if (isReps && _repsError) // Conditionally show error text
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
}
