import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_bottom_nav_bar_controller.dart';

class CustomBottomNavBar extends ConsumerWidget {
  final GlobalKey<ScaffoldState> drawerKey;
  CustomBottomNavBar({this.drawerKey});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _selectedIndexState = watch(bottomNavBarStateNotifier.state);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
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
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: "Messages",
        ),
      ],
      currentIndex: _selectedIndexState.data.value,
      onTap: (index) => context
          .read(bottomNavBarStateNotifier)
          .changeSelectedIndex(index, drawerKey, context),
    );
  }
}
