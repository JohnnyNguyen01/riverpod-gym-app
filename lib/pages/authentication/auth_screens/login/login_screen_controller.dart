import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/firebase_auth_repo.dart';
import 'package:gym_tracker/providers/states/user_state_provider.dart';
import 'package:gym_tracker/routing/app_router.dart';

import '../../../../providers/states/signup_screen/circle_avatar_state.dart';
import '../../../../providers/states/user_state_provider.dart';

final loginScreenController =
    Provider.autoDispose((ref) => LoginScreenController(ref.read));

class LoginScreenController {
  final Reader read;

  LoginScreenController(this.read);

  ///validate the form and submit it for authenication
  void validateAndSubmit(
      TextEditingController emailController,
      TextEditingController passwordController,
      GlobalKey<FormState> formKey,
      BuildContext context) async {
    if (formKey.currentState.validate()) {
      String email = emailController.value.text;
      String password = passwordController.value.text;
      //Auth Repository Login method
      await read(firebaseAuthRepoProvider)
          .loginWithEmailAndPassword(email: email, password: password)
          .catchError(
            (e) => {
              //todo: refactor this
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e),
                  duration: Duration(seconds: 3),
                ),
              )
            },
          );
      //if successful -> map user state
      await read(userStateController).setCurrentUserFromAuthRepo();
      //set circle avatar state to user avatar
      await read(circleAvatarStateProvider).getImageFromWebStorage(
          read(userStateController.state).data.value.uid);
      // navigate to the homeScreen
      Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Incorrect Form Values"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
