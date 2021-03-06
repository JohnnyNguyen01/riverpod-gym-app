import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/domain/authentication/models/workout_model.dart';
import 'package:gym_tracker/domain/storage/firebase_firestore_service.dart';
import 'package:gym_tracker/pages/workout/workout_bottom_sheet.dart';
import 'package:gym_tracker/providers/states/user_state_provider.dart';
import 'package:gym_tracker/providers/states/workout/selected_workout_state.dart';

final homeScreenControllerProvider = Provider<HomeScreenController>((ref) {
  return HomeScreenController(ref.read);
});

class HomeScreenController {
  final Reader read;

  HomeScreenController(this.read);

  void showModalBottomSheet(GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState.showBottomSheet(
      (context) => WorkoutBottomSheet(),
      // Container(
      //   height: MediaQuery.of(context).size.height / 1.25,
      //   color: Colors.blueAccent,
      // ),
    );
  }

  void handleOnDateChange(DateTime date) async {
    final userState = read(userStateController.state);
    String uid = userState.data.value.uid;
    Workout workout = await read(databaseProvider).getUserWorkout(uid, date);
    print(workout);
    read(workoutStateprovider).setCurrentWorkout(workout);
  }
}
