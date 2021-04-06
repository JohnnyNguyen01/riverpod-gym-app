import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/models/models.dart';
import 'package:gym_tracker/pages/messaging/messaging_screen.dart';
import 'package:gym_tracker/states/messages/message_state.dart';
import 'package:gym_tracker/states/states.dart';

final messagingContactsControllerProvider =
    Provider<MessagingContactsScreenController>((ref) {
  return MessagingContactsScreenController(read: ref.read);
});

class MessagingContactsScreenController {
  final Reader read;

  MessagingContactsScreenController({@required this.read});

  void initializeState() async {
    final uid = read(userStateController.state).data.value.uid;
    read(messagingContactStateProvider).getMessagingContactsList(uid: uid);
  }

  void handleOnChatRoomTap(
      {@required BuildContext context, @required MessageContact roomInfo}) {
    read(messageRoomStateProvider).setMessageRoomModel(roomInfo: roomInfo);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MessagingScreen()));
  }
}
