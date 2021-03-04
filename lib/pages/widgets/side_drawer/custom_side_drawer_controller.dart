import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/firebase_auth_repo.dart';
import 'package:gym_tracker/pages/widgets/side_drawer/name_change_dialog/name_change_dialog.dart';
import 'package:gym_tracker/pages/widgets/side_drawer/photo_dialog_box/photo_dialog_box.dart';
import 'package:gym_tracker/providers/states/signup_screen/circle_avatar_state.dart';
import 'package:gym_tracker/providers/states/user_state_provider.dart';
import 'package:gym_tracker/routing/app_router.dart';

final customSideDrawerController =
    Provider.autoDispose<CustomSideDrawerController>((ref) {
  return CustomSideDrawerController(ref.read);
});

class CustomSideDrawerController {
  final Reader read;
  CustomSideDrawerController(this.read);

  void handleLogoutBtn(BuildContext context) async {
    await read(userStateController).removeCurrentUser();
    read(circleAvatarStateProvider).resetStateToDefault();
    await read(firebaseAuthRepoProvider).logOut().whenComplete(() =>
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.initAuthScreen, (Route<dynamic> route) => false));
  }

  void handleEditCircleAvatarBtn(BuildContext context) {
    showDialog(context: context, builder: (_) => PhotoDialogBox());
  }

  void handleEditNameBtn(BuildContext context) {
    showDialog(context: context, builder: (_) => NameChangeDialog());
  }
}
