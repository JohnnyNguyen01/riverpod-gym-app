import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/models/models.dart';
import 'package:gym_tracker/domain/storage/firebase_firestore_service.dart';

final messagingContactStateProvider =
    StateNotifierProvider<MessagingContactsState>((ref) {
  return MessagingContactsState(read: ref.read);
});

class MessagingContactsState
    extends StateNotifier<AsyncValue<List<MessageContact>>> {
  final Reader read;

  MessagingContactsState({@required this.read}) : super(AsyncData([]));

  void getMessagingContactsList({@required String uid}) async {
    List<MessageContact> latestChatRooms =
        await read(databaseProvider).getChatRooms(uid: uid);
    state = AsyncData(latestChatRooms);
  }
}
