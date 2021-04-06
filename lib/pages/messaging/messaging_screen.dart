import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/pages/messaging/messaging_screen_controller.dart';
import 'package:gym_tracker/pages/messaging/widgets/message_bubble.dart';
import 'package:gym_tracker/states/messages/message_state.dart';

class MessagingScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final roomInfo = watch(messageRoomStateProvider.state).data.value;
    final chatMessages = watch(chatMessagesProvider);
    // final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  CachedNetworkImageProvider(roomInfo.coachImagURL, scale: 1),
            ),
            const SizedBox(width: 5),
            Text(
              roomInfo.coach,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: chatMessages.when(
                data: (messageList) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: messageList.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, i) {
                          return MessageBubble(message: messageList[i]);
                        }),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (err, st) => Text(err)),
          ),
          _BuildInputRow(watch: watch),
        ],
      ),
    );
  }
}

class _BuildInputRow extends StatelessWidget {
  const _BuildInputRow({
    @required this.watch,
  });

  final ScopedReader watch;

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              onChanged: (_) => print(_inputController.text),
            ),
          ),
          const SizedBox(width: 14),
          ElevatedButton(
            child: Text('Send'),
            onPressed: () async {
              watch(messagingScreenController).handleSendButton(
                  controller: _inputController, context: context);
            },
          )
        ],
      ),
    );
  }
}
