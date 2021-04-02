import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routing/app_router.dart';

final bottomNavBarStateNotifier =
    StateNotifierProvider<CustomBottomNavBarStateNotifier>(
        (ref) => CustomBottomNavBarStateNotifier(ref.read));

class CustomBottomNavBarStateNotifier extends StateNotifier<AsyncValue<int>> {
  CustomBottomNavBarStateNotifier(this.read) : super(AsyncLoading()) {
    _init();
  }

  final Reader read;

  void _init() async {
    state = AsyncValue.data(0);
  }

  ///Triggered each time the user taps on a new BottomNavBar element.
  ///Hgihlights the new elements and is kept persistent even when app is closed
  ///or a change in screens.
  void changeSelectedIndex(int index, GlobalKey<ScaffoldState> drawerKey,
      BuildContext context) async {
    state = AsyncLoading();
    state = AsyncValue.data(index);
    handleIndexSwitch(index, drawerKey, context);
  }

  void handleIndexSwitch(
      int index, GlobalKey<ScaffoldState> drawerKey, BuildContext context) {
    switch (index) {
      case 0:
        handleProfileBtn(drawerKey);
        break;
      case 1:
        print("History bottom nav bar tab selected");
        break;
      case 2:
        print("Workout bottom nav bar selected");
        break;
      case 3:
        Navigator.of(context).pushNamed(AppRoutes.messagingContactsScreen);
    }
  }

  void handleProfileBtn(GlobalKey<ScaffoldState> drawerKey) {
    drawerKey.currentState.openDrawer();
  }
}
