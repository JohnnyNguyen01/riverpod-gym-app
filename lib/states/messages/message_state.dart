import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/models/models.dart';
import 'package:gym_tracker/domain/storage/firebase_firestore_service.dart';

final chatMessagesProvider =
    StreamProvider.autoDispose<List<Message>>((ref) async* {
  final messageRoomState = ref.read(messageRoomStateProvider.state).data.value;
  final messageStream = ref.read(databaseProvider).getChatRoomStream(
      coachUID: messageRoomState.coachID, clientUID: messageRoomState.clientID);

  await for (final message in messageStream) {
    yield message;
  }
});

final messageRoomStateProvider = StateNotifierProvider<MessageRoomState>((ref) {
  return MessageRoomState(read: ref.read);
});

class MessageRoomState extends StateNotifier<AsyncValue<MessageContact>> {
  final Reader read;
  MessageRoomState({@required this.read})
      : super(AsyncData(MessageContact.init()));

  void setMessageRoomModel({@required MessageContact roomInfo}) {
    state = AsyncData(roomInfo);
  }

  void setCoach({@required String coachID}) {
    final currentState = state.data.value;
    final newState = currentState.copyWith(coachID: coachID);
    state = AsyncData(newState);
  }
}
