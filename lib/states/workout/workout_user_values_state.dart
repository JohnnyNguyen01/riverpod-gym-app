import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/models/models.dart';

final workoutUserValuesStateprovider = StateNotifierProvider<WorkoutUserValues>(
    (ref) => WorkoutUserValues(ref.read));

class WorkoutUserValues
    extends StateNotifier<AsyncData<WorkoutUserValuesModel>> {
  final Reader read;

  WorkoutUserValues(this.read)
      : super(AsyncData(WorkoutUserValuesModel.initEmpty()));

  ///Reset init state due to date time issue for `completedAt` property
  ///todo: Find fix for this
  void initStateFix() {
    final currentState = state.data.value;
    WorkoutUserValuesModel newInitState =
        currentState.copyWith(completedAt: DateTime.now());
    state = AsyncData(newInitState);
    print(newInitState.completedAt);
  }

  ///Sets the completed workout note
  void addWorkoutNote(String workoutNote) {
    final currentState = state.data.value;
    final newState = WorkoutUserValuesModel(
        completedAt: currentState.completedAt,
        startedAt: currentState.startedAt,
        workoutNote: workoutNote,
        workoutCompletionTime: currentState.workoutCompletionTime,
        filledOutExercises: currentState.filledOutExercises);
    state = AsyncValue.data(newState);
  }

  //Sets the `startTime` DateTime property.
  void setStartTime(DateTime startTime) {
    final currentState = state.data.value;
    final newState = WorkoutUserValuesModel(
        startedAt: startTime,
        completedAt: currentState.completedAt,
        workoutNote: currentState.workoutNote,
        workoutCompletionTime: currentState.workoutCompletionTime,
        filledOutExercises: currentState.filledOutExercises);
    state = AsyncValue.data(newState);
  }

  //Sets the `completedAt` DateTime property to `DateTime.now()`.
  Future<void> setCompletedAt(DateTime completedAt) async {
    final currentState = state.data.value;
    final newState = WorkoutUserValuesModel(
        startedAt: currentState.startedAt,
        completedAt: completedAt,
        workoutNote: currentState.workoutNote,
        workoutCompletionTime: currentState.workoutCompletionTime,
        filledOutExercises: currentState.filledOutExercises);
    state = AsyncValue.data(newState);
  }

  ///Sets the time the user took to complete the workout
  void setCompletedTime({@required int completionTime}) {
    final currentState = state.data.value;
    final newState = WorkoutUserValuesModel(
        completedAt: currentState.completedAt,
        workoutNote: currentState.workoutNote,
        startedAt: currentState.startedAt,
        workoutCompletionTime: completionTime,
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
        workoutCompletionTime: currentState.workoutCompletionTime,
        startedAt: currentState.startedAt,
        filledOutExercises: newfilledOutExercisesState);
    state = AsyncValue.data(newState);
  }

  /// Add or change the user entered sets and reps for each exercise.
  void setKgRepsToFilleldOutExercise(
      {@required String exerciseName,
      @required int setNumber,
      @required int kg,
      @required int reps}) {
    final currentState = state.data.value;
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
        workoutNote: currentState.workoutNote,
        workoutCompletionTime: currentState.workoutCompletionTime,
        completedAt: currentState.completedAt,
        startedAt: currentState.startedAt,
        filledOutExercises: newList);
    //assign to state
    state = AsyncValue.data(newState);
  }

  void removeSetFromExercise(
      {@required String exerciseName, @required int setNumber}) {
    final currentState = state.data.value;
    final filledOutExercisesList = state.data.value.filledOutExercises;
    FilledOutExercises exerciseToEdit;

    filledOutExercisesList.forEach((element) {
      if (element.exerciseName == exerciseName) {
        exerciseToEdit = element;
      }
    });

    //find set
    if (exerciseToEdit != null) {
      //remove old FilledOutExercise
      filledOutExercisesList.remove(exerciseToEdit);
      //remove set from new one
      exerciseToEdit.setsValues
          .removeWhere((element) => element["set"] == setNumber);
      //new FilledOutExercise List
      List<FilledOutExercises> newList = [
        ...filledOutExercisesList,
        exerciseToEdit
      ];
      //change the value in an immutable fashion
      final newState = WorkoutUserValuesModel(
          workoutNote: currentState.workoutNote,
          completedAt: currentState.completedAt,
          workoutCompletionTime: currentState.workoutCompletionTime,
          startedAt: currentState.startedAt,
          filledOutExercises: newList);
      //assign to state
      state = AsyncValue.data(newState);
    }
  }

  ///Deletes all `FilledOutExercises`
  void clearFilledOutExercisesList() {
    final filldOutExercisesList = state.data.value.filledOutExercises;
    filldOutExercisesList.clear();
  }
}
