import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/states/workout/workout_user_values_state.dart';

class WorkoutTimer extends StatefulWidget {
  @override
  _WorkoutTimerState createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer> {
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  bool isFinished = false;
  DateTime _startTime = DateTime.now();
  DateTime _endTime;
  Timer timer;
  static final container = ProviderContainer();

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

  ///Sets the `isFinished` property to true in order to complete the workout
  ///and then submits the `workoutCompletionTime` to the `workoutUserValues`
  ///state.
  void completeWorkout() {
    _endTime = DateTime.now();
    setState(() {
      isFinished = true;
    });
    container
        .read(workoutUserValuesStateprovider)
        .setCompletedTime(completionTime: workoutCompletionTime());
  }

  ///Returns in `minutes` the time the user took to complete the workout.
  int workoutCompletionTime() {
    final difference = _endTime.difference(_startTime);
    return difference.inMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'workout time: $_hours : $_minutes : $_seconds',
      style: TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
