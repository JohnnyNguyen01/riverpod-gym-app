import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/firebase_auth_repo.dart';

import '../../../../domain/camera_services/image_picker.dart';
import '../../../../providers/states/signup_screen/circle_avatar_state.dart';

final signUpScreenController =
    Provider.autoDispose((ref) => SignUpScreenController(ref.read));

class SignUpScreenController {
  final Reader read;

  SignUpScreenController(this.read);

  void validateAndSubmitForm(
      {TextEditingController emailController,
      TextEditingController firstPassController,
      TextEditingController secondPassController,
      BuildContext context,
      GlobalKey<FormState> formKey}) async {
    if (formKey.currentState.validate()) {
      await read(firebaseAuthRepoProvider)
          .signUpWithEmailAndPassword(
              email: emailController.text, password: secondPassController.text)
          .catchError((e) => _showErrorSnackbar(context, e));
    } else {
      _showErrorSnackbar(context, "Invalid form ");
    }
  }

  void _showErrorSnackbar(BuildContext context, String errorText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorText),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void handleEdtAvatarBtn() {
    read(circleAvatarStateProvider).getImageFromCamera();
  }
}
