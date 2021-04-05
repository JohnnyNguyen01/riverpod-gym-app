import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messagingContactsControllerProvider =
    Provider<MessagingContactsScreenController>((ref) {
  return MessagingContactsScreenController(read: ref.read);
});

class MessagingContactsScreenController {
  final Reader read;

  MessagingContactsScreenController({@required this.read});
}
