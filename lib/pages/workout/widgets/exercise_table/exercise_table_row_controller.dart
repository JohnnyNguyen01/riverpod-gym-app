import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/providers/states/workout/workout_user_values_state.dart';

final exerciseTableRowControllerProvider =
    Provider<ExerciseTableRowController>((ref) {
  return ExerciseTableRowController(ref.read);
});

class ExerciseTableRowController {
  final Reader read;
  ExerciseTableRowController(this.read);

  bool validateForm({@required GlobalKey<FormState> formKey}) {
    return formKey.currentState.validate();
  }

  void submitKgRepsForm(
      {@required TextEditingController kgController,
      @required TextEditingController repsController,
      @required String exerciseName}) {
    final _workoutValuesProvider = read(workoutUserValuesStateprovider);
    _workoutValuesProvider.addKgRepsToFilleldOutExercise(exerciseName,
        int.parse(kgController.text), int.parse(repsController.text));
  }

  bool handleOnTickBoxTapped(
      {@required GlobalKey<FormState> formKey,
      @required TextEditingController kgController,
      @required TextEditingController repsController,
      @required String exerciseName}) {
    bool result = validateForm(formKey: formKey);
    submitKgRepsForm(
        kgController: kgController,
        repsController: repsController,
        exerciseName: exerciseName);

    return result;
  }
}
