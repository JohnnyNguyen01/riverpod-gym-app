import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/models/models.dart';

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
