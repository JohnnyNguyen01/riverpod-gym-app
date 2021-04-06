import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/states/coach/coach_state.dart';
import 'package:gym_tracker/states/states.dart';
import '../../../../domain/authentication/firebase_auth_repo.dart';
import '../../../../routing/app_router.dart';

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
      //set isLoadingState to true
      read(loginStateProvider).changeLoginState(true);
      //Dismiss keyboard
      FocusScope.of(context).requestFocus(FocusNode());
      //Auth Repository Login method
      await read(firebaseAuthRepoProvider)
          .loginWithEmailAndPassword(email: email, password: password)
          .catchError(
        (e) async {
          //set loginState to false if error
          read(loginStateProvider).changeLoginState(false);
          //todo: refactor this
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e),
              duration: Duration(seconds: 3),
            ),
          );
        },
      );
      //if successful -> map user state
      await read(userStateController)
          .setUserFromDatabase(read(firebaseAuthRepoProvider).uid);
      final user = read(userStateController.state).data.value;
      //set circle avatar state to user avatar
      String photoURL = user.profileImageURL;
      read(circleAvatarStateProvider).getImageFromURL(photoURL);
      //set Login State to false
      read(loginStateProvider).changeLoginState(false);
      //Set coach object
      read(coachStateProvider).setCoachFromDatabase(coachUID: user.coachUID);

      // navigate to the homeScreen
      Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Incorrect Form Values"),
          duration: Duration(seconds: 2),
        ),
      );
      //  set loginState to false if error
      read(loginStateProvider).changeLoginState(false);
    }
  }
}
