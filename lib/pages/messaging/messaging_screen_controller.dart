import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/models/models.dart';
import 'package:gym_tracker/domain/storage/firebase_firestore_service.dart';
import 'package:gym_tracker/pages/widgets/error_snack_bar.dart';
import 'package:gym_tracker/states/states.dart';

final messagingScreenControllerProvider =
    Provider<MessagingScreenController>((ref) {
  return MessagingScreenController(read: ref.read);
});

class MessagingScreenController {
  final Reader read;

  MessagingScreenController({@required this.read});

  void handleLeadingBackButton({@required BuildContext context}) =>
      Navigator.of(context).pop();

  void handleSendButton(
      {@required TextEditingController controller,
      BuildContext context}) async {
    final roomDetails = read(messageRoomStateProvider.state).data.value;
    final userDetails = read(userStateController.state).data.value;
    try {
      await read(databaseProvider).addMessageToChatRoom(
          coachUID: roomDetails.coachID,
          clientUID: roomDetails.clientID,
          message: Message(
              message: controller.text,
              sentAt: DateTime.now(),
              sentBy: userDetails.userName,
              profileImageURL: userDetails.profileImageURL,
              senderUID: userDetails.uid));

      read(messageRoomStateProvider).setLatestMessage(
          message: controller.text,
          sentBy: userDetails.uid,
          sentAt: DateTime.now());

      final newRoomInfo = read(messageRoomStateProvider.state).data.value;
      read(databaseProvider).updateChatRoomDoc(roomInfo: newRoomInfo);
      controller.text = '';
    } on Failure catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(ErrorSnackBar(message: e.message).snackbar());
    }
  }
}
