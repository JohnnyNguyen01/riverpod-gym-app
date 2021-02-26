import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/storage/firebase_firestore_service.dart';

import '../../../../providers/states/user_state_provider.dart';

final nameChangeDialogControllerProvider =
    Provider<NameChangeDialogController>((ref) {
  return NameChangeDialogController(ref.read);
});

class NameChangeDialogController {
  final Reader read;

  NameChangeDialogController(this.read);

  void handleSubmitBtn(
      {BuildContext context,
      TextEditingController nameController,
      GlobalKey<FormState> formKey}) async {
    if (formKey.currentState.validate()) {
      //change internal state name
      read(userStateController).setUserName(nameController.text);
      //change name in database
      final String uid = read(userStateController).state.data.value.uid;
      read(databaseProvider).setUserName(uid, nameController.text);
      //pop context after
      Navigator.of(context).pop();
    }
  }
}
