import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/pages/widgets/side_drawer/custom_side_drawer_controller.dart';

class SideDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _controller = watch(customSideDrawerController);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text("{User} Profile"),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ElevatedButton(
            onPressed: () => _controller.handleLogoutBtn(context),
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
