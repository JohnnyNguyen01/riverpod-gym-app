import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/authentication/firebase_auth_repo.dart';
import '../../../../domain/models/models.dart';
import '../../../../domain/storage/firebase_cloud_storage_service.dart';
import '../../../../domain/storage/firebase_firestore_service.dart';
import 'package:gym_tracker/states/states.dart';
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
    final circleAvatarState = read(circleAvatarStateProvider.state);
    final circleAvatarPath = circleAvatarState.data.value.entries.first.key;
    final userState = read(userStateController);

    if (formKey.currentState.validate() && circleAvatarState.data != null) {
      //set login state to true
      read(loginStateProvider).changeLoginState(true);
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
                  email: read(userStateController.state).data.value.email,
                  uid: read(userStateController.state).data.value.uid,
                  coachUID: '',
                  profileImageURL: await context
                      .read(storageCloudService)
                      .getUserProfilePhotoUrl(
                          read(userStateController.state).data.value.uid))))
          .then((_) async => await userState.setUserName(nameController.text))
          //3. catch any errors
          .catchError((e) {
        _showErrorSnackbar(context, e);
        //set loginState to false
        read(loginStateProvider).changeLoginState(false);
      })
          //5. Navigate to homeScreen
          .then((value) =>
              Navigator.popAndPushNamed(context, AppRoutes.homeScreen));
    } else {
      //set loginState to false
      read(loginStateProvider).changeLoginState(false);
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
