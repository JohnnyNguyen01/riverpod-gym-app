import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/firebase_auth_repo.dart';
import 'package:gym_tracker/pages/home/home_screen.dart';
import 'package:gym_tracker/providers/states/user_state_provider.dart';

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
      context.read(userStateController).getCurrentUser();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (c) => HomeScreen()));
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
