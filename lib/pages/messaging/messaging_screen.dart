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
    final roomInfoController = watch(messageRoomStateProvider);
    final chatMessages = watch(chatMessagesProvider);
    // final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  CachedNetworkImageProvider(roomInfo.coachImageURL, scale: 1),
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: [
            Expanded(
              child: chatMessages.when(
                  data: (messageList) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ListView.builder(
                          reverse: true,
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
      ),
    );
  }
}

class _BuildInputRow extends StatefulWidget {
  const _BuildInputRow({
    @required this.watch,
  });

  final ScopedReader watch;

  @override
  __BuildInputRowState createState() => __BuildInputRowState();
}

class __BuildInputRowState extends State<_BuildInputRow> {
  bool _buttonIsEnabled = false;
  final _inputController = TextEditingController();

  void setButtonIsEnabled() {
    _inputController.text.isNotEmpty
        ? _buttonIsEnabled = true
        : _buttonIsEnabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.white,
          child: Material(
            elevation: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _inputController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your message here"),
                  onChanged: (_) {
                    setState(() {
                      setButtonIsEnabled();
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _buttonIsEnabled
                    ? () async {
                        widget
                            .watch(messagingScreenController)
                            .handleSendButton(
                                controller: _inputController, context: context);
                      }
                    : () {},
                icon: Icon(
                  Icons.send,
                  color: _buttonIsEnabled ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _inputController.dispose();
  }
}
