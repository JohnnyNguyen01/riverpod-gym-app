import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/models/message_model.dart';
import 'package:gym_tracker/states/messages/message_state.dart';

class MessagingScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final roomInfo = watch(messageRoomStateProvider.state).data.value;
    final chatMessages = watch(chatMessagesProvider);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(roomInfo.coach,
            style: textTheme.headline6.copyWith(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: chatMessages.when(
                data: (messageList) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: messageList.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Text(messageList[i].message);
                      });
                },
                loading: () => const CircularProgressIndicator(),
                error: (err, st) => Text(err)),
          ),
          // Expanded(
          //   child: StreamBuilder(
          //       stream: chatMessages,
          //       builder: (context, AsyncSnapshot<List<Message>> snapshot) {
          //         return ListView.builder(
          //             shrinkWrap: true,
          //             itemCount: snapshot.data.length,
          //             itemBuilder: (context, i) {
          //               return Text('${snapshot.data[i].message}');
          //             });
          //       }),
          // ),
          _buildInputRow(watch: watch),
        ],
      ),
    );
  }

  Widget _buildInputRow({@required ScopedReader watch}) {
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
              print('pressed');
            },
          )
        ],
      ),
    );
  }
}
