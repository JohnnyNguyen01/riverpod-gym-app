import 'dart:async';

import 'package:flutter/material.dart';

class WorkoutTimer extends StatefulWidget {
  @override
  _WorkoutTimerState createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer> {
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  DateTime _startTime = DateTime.now();
  DateTime _endTime;
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _endTime = DateTime.now();
        if (_seconds < 0) {
          timer.cancel();
        } else {
          _seconds = _seconds + 1;
          if (_seconds > 59) {
            _minutes += 1;
            _seconds = 0;
            if (_minutes > 59) {
              _hours += 1;
              _minutes = 0;
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'workout time: $_hours : $_minutes : $_seconds',
      style: TextStyle(color: Colors.grey),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
