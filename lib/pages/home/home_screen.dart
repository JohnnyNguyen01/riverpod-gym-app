import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/models/workout_model.dart';
import 'package:gym_tracker/domain/storage/firebase_firestore_service.dart';
import 'package:gym_tracker/pages/home/home_screen_controller.dart';
import 'package:gym_tracker/pages/home/summary_workout_card.dart';
import 'package:gym_tracker/pages/widgets/bottom_nav_bar/custom_bottom_navbar.dart';
import 'package:gym_tracker/pages/widgets/side_drawer/custom_side_drawer.dart';
import 'package:gym_tracker/providers/states/user_state_provider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import '../../providers/states/user_state_provider.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUserState = watch(userStateController);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    final homeScreenController = watch(homeScreenControllerProvider);

    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: CustomBottomNavBar(drawerKey: _scaffoldKey),
      drawer: SideDrawer(),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              _BuildMockDateTimePicker(),
              SizedBox(height: 15),
              _BuildTodaysWorkoutHeading(),
              BuildWorkoutCard(
                exercises: ["exercise 1", 'exercise 2', 'exercise 3'],
                title: "Back",
                onTap: () =>
                    homeScreenController.showModalBottomSheet(_scaffoldKey),
                // _BuildMockTable()
              ),
              ElevatedButton(
                onPressed: () async {
                  final uid = currentUserState.state.data.value.uid;
                  DateTime now = DateTime.now();
                  DateTime newNow = DateTime(now.year, now.month, now.day);
                  Workout test = await context
                      .read(databaseProvider)
                      .getUserWorkout(uid, newNow);
                  print(test);
                },
                child: Text("test doc retrieval"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildMockDateTimePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime.now(),
      initialSelectedDate: DateTime.now(),
      selectionColor: Colors.black,
      selectedTextColor: Colors.white,
      height: 95,
      onDateChange: (date) {
        // New date selected
        print(date);
      },
    );
  }
}

class _BuildTodaysWorkoutHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "Today's Workout",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
