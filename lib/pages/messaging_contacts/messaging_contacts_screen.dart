import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/models/models.dart';
import 'package:gym_tracker/pages/messaging_contacts/messaging_contacts_screen_controller.dart';
import 'package:gym_tracker/states/states.dart';

class MessagingContactsScreen extends StatefulWidget {
  @override
  _MessagingContactsScreenState createState() =>
      _MessagingContactsScreenState();
}

class _MessagingContactsScreenState extends State<MessagingContactsScreen> {
  @override
  void initState() {
    super.initState();
    context.read(messagingContactsControllerProvider).initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              Consumer(
                builder: (context, watch, child) {
                  final messageContactsList =
                      watch(messagingContactStateProvider.state).data.value;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: messageContactsList.length,
                      itemBuilder: (context, index) {
                        return _buildContactCard(
                            context: context,
                            roominfo: messageContactsList[index]);
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      '🏋️‍♂️ Messages.',
      style: Theme.of(context)
          .textTheme
          .headline5
          .copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildContactCard({
    @required BuildContext context,
    @required MessageContact roominfo,
  }) {
    final sentAtDateTime = roominfo.sentAt.toDate();
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Card(
        elevation: 1,
        child: ListTile(
          horizontalTitleGap: 15,
          minVerticalPadding: 10,
          leading: CircleAvatar(
            backgroundImage:
                CachedNetworkImageProvider(roominfo.coachImageURL, scale: 1),
            radius: 25,
          ),
          onTap: () => context
              .read(messagingContactsControllerProvider)
              .handleOnChatRoomTap(context: context, roomInfo: roominfo),
          title: Text(
            roominfo.coach,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            roominfo.latestMessage,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          trailing: Column(
            children: [
              //time of message received
              Text(
                '${sentAtDateTime.hour} : ${sentAtDateTime.second}',
                style: TextStyle(color: Colors.grey.shade900),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
