import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/pages/workout/widgets/exercise_table.dart';
import 'package:gym_tracker/providers/states/workout/selected_workout_state.dart';

class WorkoutBottomSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final workoutState = watch(workoutStateprovider.state);
    final workoutValues = workoutState.data.value;

    return Container(
      padding: EdgeInsets.only(top: 30),
      child: SafeArea(
        child: Scaffold(
          //Used to help unfocus the workoutNoteTextField widget
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _BuildWorkoutHeading(workoutValues.exerciseDay.toString()),
                    const SizedBox(height: 15),
                    _BuildTimer(),
                    const SizedBox(height: 15),
                    _BuildTextDescription(workoutValues.exerciseDescription),
                    const SizedBox(height: 15),
                    _BuildWorkoutNoteTextField(),
                    const SizedBox(height: 15),
                    _BuildWorkoutColumn(),
                    _TestBtn(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//todo: remove
class _TestBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text("Grab workout state"),
      onPressed: () =>
          print(context.read(workoutStateprovider).state.data.value.toString()),
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

//todo: implement timer
class _BuildTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "07:18",
      style: TextStyle(color: Colors.grey),
    );
  }
}

class _BuildWorkoutNoteTextField extends StatelessWidget {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: "Workout note",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}

class _BuildWorkoutColumn extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _workoutState = watch(workoutStateprovider).state.data.value;
    final exercise = _workoutState.exerciseList[0];
    return ExerciseTable(
      exercise: exercise,
    );
  }
}
