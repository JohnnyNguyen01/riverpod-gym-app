import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gym_tracker/domain/authentication/models/filled_out_exercises.dart';
import 'package:gym_tracker/domain/authentication/models/workout_model.dart';

class WorkoutUserValuesModel {
  Timestamp completedAt;
  String workoutNote;
  List<FilledOutExercises> filledOutExercises;

  WorkoutUserValuesModel({
    this.completedAt,
    this.workoutNote,
    this.filledOutExercises,
  });

  WorkoutUserValuesModel.initEmpty() {
    this.completedAt = Timestamp.now();
    this.workoutNote = "";
    this.filledOutExercises = [];
  }
}
