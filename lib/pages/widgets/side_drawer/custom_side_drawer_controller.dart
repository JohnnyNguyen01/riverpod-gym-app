import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/authentication/firebase_auth_repo.dart';
import 'package:gym_tracker/states/states.dart';
import '../../../routing/app_router.dart';
import 'name_change_dialog/name_change_dialog.dart';
import 'photo_dialog_box/photo_dialog_box.dart';

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
