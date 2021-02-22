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
          _BuildLogoutButton(
            onPressed: () => _controller.handleLogoutBtn(context),
          )
        ],
      ),
    );
  }
}

class _BuildLogoutButton extends StatelessWidget {
  final Function onPressed;

  const _BuildLogoutButton({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        onPressed: () => onPressed(),
        child: Text("Logout"),
      ),
    );
  }
}
