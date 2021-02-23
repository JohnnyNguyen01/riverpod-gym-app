import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gym_tracker/pages/widgets/side_drawer/custom_side_drawer_controller.dart';
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
          _BuildEmailTile(_userState.data.value.email),
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
              radius: 46,
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

class _BuildEmailTile extends StatelessWidget {
  final String currentuserEmail;

  const _BuildEmailTile(this.currentuserEmail);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (buildContext, constraint) => Column(
        children: [
          ListTile(
            title: Text(
              "Email",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(currentuserEmail ?? "ERROR"),
            trailing: IconButton(
              icon: Icon(Icons.arrow_right),
              onPressed: () {},
            ),
          ),
          Container(
            width: constraint.maxWidth * 0.9,
            height: 1,
            color: Colors.grey.shade300,
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
