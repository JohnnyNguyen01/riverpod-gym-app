class Exercise {
  String exerciseName;
  String exerciseURL;
  String sets;
  String reps;

  Exercise.fromFirestore(Map<String, dynamic> snapshot) {
    exerciseName = snapshot["exerciseName"];
    exerciseURL = snapshot["exerciseURL"];
    sets = snapshot["sets"];
    reps = snapshot["reps"];
  }

  @override
  String toString() {
    return "[$exerciseName, $exerciseURL, $sets, $reps]";
  }
}
