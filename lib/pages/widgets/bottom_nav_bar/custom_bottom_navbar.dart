import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/pages/widgets/bottom_nav_bar/custom_bottom_nav_bar_controller.dart';

class CustomBottomNavBar extends ConsumerWidget {
  final GlobalKey<ScaffoldState> drawerKey;
  CustomBottomNavBar({this.drawerKey});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _selectedIndexState = watch(bottomNavBarStateNotifier.state);

    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          label: 'Workout',
          icon: Icon(Icons.add),
        ),
      ],
      currentIndex: _selectedIndexState.data.value,
      onTap: (index) => context
          .read(bottomNavBarStateNotifier)
          .changeSelectedIndex(index, drawerKey),
    );
  }
}
