import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/firebase_auth_repo.dart';

final customSideDrawerController =
    Provider.autoDispose<CustomSideDrawerController>((ref) {
  return CustomSideDrawerController(ref.read);
});

class CustomSideDrawerController {
  final Reader read;
  CustomSideDrawerController(this.read);

  void handleLogoutBtn(BuildContext context) async {
    await read(firebaseAuthRepoProvider).logOut().whenComplete(
        () => Navigator.of(context).popUntil((route) => route.isFirst));
  }
}
