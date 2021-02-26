import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/firebase_auth_repo.dart';
import 'package:gym_tracker/domain/storage/firebase_cloud_storage_service.dart';
import 'package:gym_tracker/domain/storage/firebase_firestore_service.dart';
import 'package:gym_tracker/providers/states/auth_state_change_provider.dart';

import '../../../../domain/authentication/models/user_model.dart';
import '../../../../providers/states/signup_screen/circle_avatar_state.dart';
import '../../../../providers/states/user_state_provider.dart';
import '../../../../providers/states/user_state_provider.dart';
import '../../../../routing/app_router.dart';

final signUpScreenController =
    Provider.autoDispose((ref) => SignUpScreenController(ref.read));

class SignUpScreenController {
  final Reader read;

  SignUpScreenController(this.read);

  void validateAndSubmitForm(
      {TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController firstPassController,
      TextEditingController secondPassController,
      BuildContext context,
      GlobalKey<FormState> formKey}) async {
    final circleAvatarState = read(circleAvatarStateProvider);
    final circleAvatarPath =
        circleAvatarState.state.data.value.entries.first.key;
    final userState = read(userStateController);

    if (formKey.currentState.validate() &&
        circleAvatarState.state.data != null) {
      await read(firebaseAuthRepoProvider)
          //1. sign up with email password
          .signUpWithEmailAndPassword(
              email: emailController.text, password: secondPassController.text)
          //  Update user state object
          .then((_) async => await userState.setCurrentUserFromAuthRepo())
          // upload profile photo to cloud
          .then((_) async => await read(storageCloudService)
              .addNewUserProfilephoto(File(circleAvatarPath),
                  context.read(authStateChangesProvider).data.value.uid))
          //4. upload user details to database
          // todo: implement proper username
          .then((value) async => await context
              .read(databaseProvider)
              .addNewUser(UserModel(
                  userName: nameController.text,
                  email: userState.state.data.value.email,
                  uid: userState.state.data.value.uid,
                  profileImageURL: await context
                      .read(storageCloudService)
                      .getUserProfilePhotoUrl(userState.state.data.value.uid))))
          .then((_) async => await userState.setUserName(nameController.text))
          //3. catch any errors
          .catchError((e) => _showErrorSnackbar(context, e))
          //5. Navigate to homeScreen
          .then((value) =>
              Navigator.popAndPushNamed(context, AppRoutes.homeScreen));
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
