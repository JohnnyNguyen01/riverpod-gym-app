import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gym_tracker/pages/widgets/side_drawer/custom_side_drawer_controller.dart';
import 'package:gym_tracker/pages/widgets/side_drawer/drawer_tile.dart';
import 'package:gym_tracker/providers/states/user_state_provider.dart';

class SideDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _controller = watch(customSideDrawerController);
    final _userState = watch(userStateController.state);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _BuildDrawerHeader(
            avatarOnPressed: () =>
                _controller.handleEditCircleAvatarBtn(context),
          ),
          DrawerTile(
              title: "User ID",
              subtitle: _userState.data.value.uid,
              onPressed: () {}),
          DrawerTile(
            title: "Email",
            subtitle: _userState.data.value.email,
            onPressed: () {},
          ),
          DrawerTile(
            title: "Name",
            subtitle: _userState.data.value.userName,
            onPressed: () {},
          ),
          _BuildLogoutButton(
            onPressed: () => _controller.handleLogoutBtn(context),
          )
        ],
      ),
    );
  }
}

class _BuildDrawerHeader extends StatelessWidget {
  final Function avatarOnPressed;

  const _BuildDrawerHeader({this.avatarOnPressed});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Profile",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          Stack(clipBehavior: Clip.none, children: [
            CircleAvatar(
              backgroundColor: Colors.white30,
              radius: 48,
            ),
            Positioned(
              right: -3,
              bottom: -5,
              child: Container(
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => avatarOnPressed(),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ]),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.redAccent.shade100,
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
