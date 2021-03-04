class Exercise {
  String exerciseName;
  String exerciseURL;

  Exercise.fromFirestore(Map<String, dynamic> snapshot) {
    exerciseName = snapshot["exerciseName"];
    exerciseURL = snapshot["exerciseURL"];
  }
}
