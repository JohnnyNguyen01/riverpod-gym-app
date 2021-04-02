import 'package:flutter_riverpod/flutter_riverpod.dart';
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
