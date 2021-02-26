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
      {TextEditingController nameController,
      GlobalKey<FormState> formKey}) async {
    //change internal state name

    //change name in database
    final String uid = read(userStateController).state.data.value.uid;
    read(databaseProvider).setUserName(uid, nameController.text);
  }
}
