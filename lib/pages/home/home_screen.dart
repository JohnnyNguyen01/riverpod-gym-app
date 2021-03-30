import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/pages/home/home_screen_controller.dart';
import 'package:gym_tracker/pages/home/summary_workout_card.dart';
import 'package:gym_tracker/pages/widgets/bottom_nav_bar/custom_bottom_navbar.dart';
import 'package:gym_tracker/pages/widgets/side_drawer/custom_side_drawer.dart';
import 'package:gym_tracker/providers/states/user_state_provider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:gym_tracker/providers/states/workout/selected_workout_state.dart';

import '../../providers/states/user_state_provider.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUserController = watch(userStateController);
    final currentUserState = watch(userStateController.state);
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
              _BuildDateTimePicker(),
              const SizedBox(height: 15),
              _BuildTodaysWorkoutHeading(),
              const SizedBox(height: 10),
              _BuildWorkoutCard(scaffoldkey: _scaffoldKey),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildDateTimePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime.now(),
      initialSelectedDate: DateTime.now(),
      selectionColor: Colors.black,
      selectedTextColor: Colors.white,
      height: 95,
      onDateChange: (date) =>
          context.read(homeScreenControllerProvider).handleOnDateChange(date),
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

class _BuildWorkoutCard extends ConsumerWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;

  const _BuildWorkoutCard({@required this.scaffoldkey});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final workoutState = watch(workoutStateprovider.state);
    if (workoutState.data.value.exerciseDay == 0) {
      return Center(
        child: Text("There are no workouts for today."),
      );
    } else
      return WorkoutCard(
        exercises: workoutState.data.value.exerciseList,
        title: "Day ${workoutState.data.value.exerciseDay}",
        description: workoutState.data.value.exerciseDescription,
        onTap: () => context
            .read(homeScreenControllerProvider)
            .showModalBottomSheet(context),
      );
  }
}
