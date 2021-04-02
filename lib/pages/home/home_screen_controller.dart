import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../domain/models/models.dart';
import '../../domain/storage/firebase_firestore_service.dart';
import '../workout/workout_bottom_sheet.dart';
import 'package:gym_tracker/states/states.dart';

final homeScreenControllerProvider = Provider<HomeScreenController>((ref) {
  return HomeScreenController(ref.read);
});

class HomeScreenController {
  final Reader read;

  HomeScreenController(this.read);

  void showModalBottomSheet(
    BuildContext context,
  ) {
    showBottomSheet<void>(
      context: context,
      builder: (context) => WorkoutBottomSheet(),
    );
  }

  void handleOnDateChange(DateTime date) async {
    final userState = read(userStateController.state);
    String uid = userState.data.value.uid;
    Workout workout = await read(databaseProvider).getUserWorkout(uid, date);
    read(workoutStateprovider).setCurrentWorkout(workout);
  }
}
