import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/models/workout_model.dart';
import 'package:gym_tracker/domain/storage/firebase_firestore_service.dart';

final workoutStateprovider =
    StateNotifierProvider<WorkoutState>((ref) => WorkoutState(ref.read));

class WorkoutState extends StateNotifier<AsyncValue<Workout>> {
  final Reader read;

  WorkoutState(this.read) : super(AsyncData(Workout.empty()));

  ///Sets the current workout state to the specified workout
  void setCurrentWorkout(Workout workout) async {
    state = AsyncLoading();
    state = AsyncData(workout);
  }
}
