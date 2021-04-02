import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/states/states.dart';

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
      @required String exerciseName,
      @required int setNumber}) {
    final _workoutValuesProvider = read(workoutUserValuesStateprovider);
    _workoutValuesProvider.setKgRepsToFilleldOutExercise(
        setNumber: setNumber,
        exerciseName: exerciseName,
        kg: int.parse(kgController.text),
        reps: int.parse(repsController.text));
  }

  bool handleOnTickBoxTapped(
      {@required GlobalKey<FormState> formKey,
      @required TextEditingController kgController,
      @required TextEditingController repsController,
      @required int setNumber,
      @required String exerciseName}) {
    final _workoutValuesProvider = read(workoutUserValuesStateprovider);
    if (validateForm(formKey: formKey)) {
      submitKgRepsForm(
          setNumber: setNumber,
          kgController: kgController,
          repsController: repsController,
          exerciseName: exerciseName);
      return true;
    } else
      _workoutValuesProvider.removeSetFromExercise(
          exerciseName: exerciseName, setNumber: setNumber);
    return false;
  }
}
