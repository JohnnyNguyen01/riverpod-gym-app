import 'package:equatable/equatable.dart';

import 'filled_out_exercises.dart';

class WorkoutUserValuesModel extends Equatable {
  final DateTime completedAt;
  final DateTime startedAt;
  final int workoutCompletionTime;
  final String workoutNote;
  final List<FilledOutExercises> filledOutExercises;

  WorkoutUserValuesModel({
    this.workoutCompletionTime,
    this.completedAt,
    this.startedAt,
    this.workoutNote,
    this.filledOutExercises,
  });

  WorkoutUserValuesModel.initEmpty()
      : this.completedAt = DateTime.now(),
        this.startedAt = DateTime.now(),
        this.workoutCompletionTime = 0,
        this.filledOutExercises = [],
        this.workoutNote = "";

  WorkoutUserValuesModel copyWith(
          {DateTime completedAt,
          DateTime startedAt,
          int workoutCompletionTime,
          String workoutNote,
          List<FilledOutExercises> filledOutExercises}) =>
      WorkoutUserValuesModel(
          completedAt: completedAt ?? this.completedAt,
          startedAt: startedAt ?? this.startedAt,
          workoutCompletionTime:
              workoutCompletionTime ?? this.workoutCompletionTime,
          workoutNote: workoutNote ?? this.workoutNote,
          filledOutExercises: filledOutExercises ?? this.filledOutExercises);

  List filledOutExercisesForFirestore() {
    List filledOutExerciseObjList = [];
    filledOutExercises.forEach((exercise) {
      filledOutExerciseObjList.add({
        'exerciseName': exercise.exerciseName,
        'setsValues': exercise.setsValues
      });
    });
    return filledOutExerciseObjList;
  }

  @override
  String toString() {
    return "completedAt: $completedAt || startedAt: $startedAt|| Workout Time: $workoutCompletionTime || Note: $workoutNote || Filled Out Exercises: $filledOutExercises ";
  }

  @override
  List<Object> get props => [
        completedAt,
        startedAt,
        workoutCompletionTime,
        workoutNote,
        filledOutExercises
      ];
}
