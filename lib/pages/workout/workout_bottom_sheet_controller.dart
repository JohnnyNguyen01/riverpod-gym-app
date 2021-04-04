import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/models/models.dart';
import 'package:gym_tracker/domain/storage/firebase_firestore_service.dart';
import 'package:gym_tracker/pages/widgets/error_snack_bar.dart';
import 'package:gym_tracker/pages/workout/widgets/workout_complete_dialog/workout_complete_dialog_box.dart';
import 'package:gym_tracker/states/states.dart';

final workoutBottomSheetControllerProvider =
    Provider<WorkoutBottomSheetController>((ref) {
  return WorkoutBottomSheetController(ref.read);
});

class WorkoutBottomSheetController {
  final Reader read;
  WorkoutBottomSheetController(this.read);

  void handleWorkoutNoteTF(String value) {
    read(workoutUserValuesStateprovider).addWorkoutNote(value);
  }

  void handleSubmitWorkoutBtn({@required BuildContext context}) async {
    try {
      String uid = read(userStateController.state).data.value.uid;
      final workoutValues =
          read(workoutUserValuesStateprovider.state).data.value;
      await read(databaseProvider)
          .uploadUserWorkoutValues(model: workoutValues, uid: uid);
      Navigator.of(context).pop();
      showDialog(
          context: context, builder: (context) => WorkoutCompleteDialogBox());
    } on Failure catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(ErrorSnackBar(message: e.message).snackbar());
    }
  }

  //todo: currently unused until fixed.
  void handleCompleteWorkoutBtn() {
    final stateController = read(workoutUserValuesStateprovider);
    final currentState = read(workoutUserValuesStateprovider.state).data.value;
    //todo: Check why this doesn't update until the second call
    stateController.setCompletedAt(DateTime.now());
    //set minutes taken to complete workout
    final completedAt = currentState.completedAt;
    final startedAt = currentState.startedAt;
    int completionTimeInMinutes = completedAt.difference(startedAt).inMinutes;
    stateController.setCompletedTime(completionTime: completionTimeInMinutes);
    // Send to firebase
    //todo: test
    print(
        'startedAt: $startedAt, completedAt: $completedAt, minutes: $completionTimeInMinutes');
    //
  }
}
