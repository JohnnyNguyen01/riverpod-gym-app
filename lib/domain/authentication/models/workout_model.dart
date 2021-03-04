import 'package:cloud_firestore/cloud_firestore.dart';

import 'exercise_model.dart';

class Workout {
  List exerciseList;
  String exerciseDescription;
  int exerciseDay;
  List dates;

  Workout.empty() {
    this.dates = [];
    this.exerciseDay = 0;
    this.exerciseDescription = " ";
    this.exerciseList = [];
  }

  Workout.fromWorkoutPlan(Map<String, dynamic> snapshot) {
    dates = snapshot["dates"];
    exerciseDay = snapshot["day"];
    exerciseDescription = snapshot["description"];
    exerciseList = snapshot["exercises"];
  }

  @override
  String toString() {
    return "Workout object: ${this.exerciseList} ${this.exerciseDescription} ${this.exerciseDay} ${this.dates}";
  }
}
