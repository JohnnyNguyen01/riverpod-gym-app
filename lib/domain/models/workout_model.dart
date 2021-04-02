import 'models.dart';

class Workout {
  List<Exercise> exerciseList;
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
    List exercises = snapshot["exercises"];
    List<Exercise> assignToExerciseList = [];
    exercises.forEach((obj) {
      assignToExerciseList.add(Exercise.fromFirestore(obj));
    });
    exerciseList = assignToExerciseList;
  }

  @override
  String toString() {
    return "Workout object: ${this.exerciseList.toString()} ${this.exerciseDescription} ${this.exerciseDay} ${this.dates}";
  }
}
