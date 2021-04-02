import 'package:cloud_firestore/cloud_firestore.dart';

import 'filled_out_exercises.dart';

class WorkoutUserValuesModel {
  DateTime completedAt;
  DateTime startedAt;
  int workoutCompletionTime;
  String workoutNote;
  List<FilledOutExercises> filledOutExercises;

  WorkoutUserValuesModel({
    this.workoutCompletionTime,
    this.completedAt,
    this.startedAt,
    this.workoutNote,
    this.filledOutExercises,
  });

  WorkoutUserValuesModel.initEmpty() {
    this.completedAt = DateTime.now();
    this.startedAt = DateTime.now();
    this.workoutNote = "";
    this.workoutCompletionTime = 0;
    this.filledOutExercises = [];
  }

  @override
  String toString() {
    return "completedAt: $completedAt || startedAt: $startedAt|| Workout Time: $workoutCompletionTime || Note: $workoutNote || Filled Out Exercises: $filledOutExercises ";
  }
}
