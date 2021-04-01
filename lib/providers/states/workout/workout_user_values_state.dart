import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/models/filled_out_exercises.dart';
import 'package:gym_tracker/domain/authentication/models/workout_user_values_model.dart';

final workoutUserValuesStateprovider = StateNotifierProvider<WorkoutUserValues>(
    (ref) => WorkoutUserValues(ref.read));

class WorkoutUserValues
    extends StateNotifier<AsyncData<WorkoutUserValuesModel>> {
  final Reader read;

  WorkoutUserValues(this.read)
      : super(AsyncData(WorkoutUserValuesModel.initEmpty()));

  void addWorkoutNote(String workoutNote) {
    final currentState = state.data.value;
    final newState = WorkoutUserValuesModel(
        completedAt: currentState.completedAt,
        workoutNote: workoutNote,
        filledOutExercises: currentState.filledOutExercises);
    state = AsyncValue.data(newState);
  }

  void addNewFilledOutExercise(
      String exerciseName, List<Map<String, int>> setsValues) {
    final currentState = state.data.value;
    final newfilledOutExercisesState = [
      ...currentState.filledOutExercises,
      FilledOutExercises(
        exerciseName: exerciseName,
        setsValues: setsValues,
      )
    ];
    final newState = WorkoutUserValuesModel(
        completedAt: currentState.completedAt,
        workoutNote: currentState.workoutNote,
        filledOutExercises: newfilledOutExercisesState);
    state = AsyncValue.data(newState);
  }

  void setKgRepsToFilleldOutExercise(
      {@required String exerciseName,
      @required int setNumber,
      @required int kg,
      @required int reps}) {
    final topLevelState = state.data.value;
    final filldOutExercisesList = state.data.value.filledOutExercises;
    //get exercise we're looking to change
    FilledOutExercises exerciseToEdit =
        FilledOutExercises(exerciseName: exerciseName, setsValues: []);

    filldOutExercisesList.forEach((element) {
      if (element.exerciseName == exerciseName) {
        exerciseToEdit = element;
      } else {
        exerciseToEdit =
            FilledOutExercises(exerciseName: exerciseName, setsValues: []);
        return false;
      }
    });
    //remove existing set if it exists
    exerciseToEdit.setsValues
        .removeWhere((element) => element['set'] == setNumber);
    //add the new kg and reps object to list
    exerciseToEdit.setsValues.add({'set': setNumber, 'kg': kg, 'reps': reps});
    //remove previous iteration of exerciseSets
    filldOutExercisesList
        .removeWhere((element) => element.exerciseName == exerciseName);
    List<FilledOutExercises> newList = [
      ...filldOutExercisesList,
      exerciseToEdit
    ];
    //change the value in an immutable fashion
    final newState = WorkoutUserValuesModel(
        workoutNote: topLevelState.workoutNote,
        completedAt: topLevelState.completedAt,
        filledOutExercises: newList);
    //assign to state
    state = AsyncValue.data(newState);
  }

  void clearFilledOutExercisesList() {
    final filldOutExercisesList = state.data.value.filledOutExercises;
    filldOutExercisesList.clear();
  }
}
