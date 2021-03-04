import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/providers/states/workout/selected_workout_state.dart';

class WorkoutBottomSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final workoutState = watch(workoutStateprovider.state);
    final workoutValues = workoutState.data.value;

    return Container(
      height: MediaQuery.of(context).size.height / 1.15,
      child: Scaffold(
        body: Center(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BuildWorkoutHeading(workoutValues.exerciseDay.toString()),
                const SizedBox(height: 15),
                _BuildTextDescription(workoutValues.exerciseDescription),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class _BuildWorkoutHeading extends StatelessWidget {
  final String day;
  _BuildWorkoutHeading(this.day);
  @override
  Widget build(BuildContext context) {
    return Text(
      "Day $day",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _BuildTextDescription extends StatelessWidget {
  final String description;

  _BuildTextDescription(this.description);

  @override
  Widget build(BuildContext context) {
    return Text(description);
  }
}
