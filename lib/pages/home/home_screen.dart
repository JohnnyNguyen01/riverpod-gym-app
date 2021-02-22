import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/firebase_auth_repo.dart';
import 'package:gym_tracker/pages/widgets/bottom_nav_bar/custom_bottom_navbar.dart';
import 'package:gym_tracker/pages/widgets/side_drawer/custom_side_drawer.dart';
import 'package:gym_tracker/providers/states/user_state_provider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUserState = watch(userStateController);
    final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

    return Scaffold(
      key: _drawerKey,
      bottomNavigationBar: CustomBottomNavBar(drawerKey: _drawerKey),
      drawer: SideDrawer(),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _BuildMockDateTimePicker(),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => print(currentUserState.state),
                child: Text("get current user state"),
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read(firebaseAuthRepoProvider).logOut();
                  },
                  child: Text('Logout'))
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
