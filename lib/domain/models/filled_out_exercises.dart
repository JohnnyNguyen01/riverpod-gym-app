class FilledOutExercises {
  String exerciseName;
  List<Map<String, int>> setsValues;

  FilledOutExercises({this.exerciseName, this.setsValues});

  @override
  String toString() {
    return 'exerciseName; $exerciseName, setsValues: $setsValues';
  }
}
