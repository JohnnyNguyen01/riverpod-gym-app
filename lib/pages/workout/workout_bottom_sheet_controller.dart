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

  void handleRepKgSubmission() {}
}
