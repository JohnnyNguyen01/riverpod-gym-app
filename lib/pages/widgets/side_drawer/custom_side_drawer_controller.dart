import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/firebase_auth_repo.dart';
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
    print(read(userStateController).state.data.value);
    await read(firebaseAuthRepoProvider).logOut().whenComplete(() =>
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.initAuthScreen, (Route<dynamic> route) => false));
  }
}
