import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/pages/messaging/messaging_screen.dart';
import 'package:gym_tracker/pages/messaging_contacts/messaging_contacts_screen_controller.dart';
import 'package:gym_tracker/pages/widgets/bottom_nav_bar/custom_bottom_navbar.dart';
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
    initializeState();
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
                            name: messageContactsList[index].coach,
                            imageURL: messageContactsList[index].coachImagURL,
                            latestMessage:
                                messageContactsList[index].latestMessage,
                            sentAt: messageContactsList[index].sentAt);
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void initializeState() async {
    final uid = context.read(userStateController.state).data.value.uid;
    context
        .read(messagingContactStateProvider)
        .getMessagingContactsList(uid: uid);
    print(context.read(messagingContactStateProvider.state).data.value);
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

  Widget _buildContactCard(
      {@required BuildContext context,
      @required String imageURL,
      @required String name,
      @required String latestMessage,
      @required Timestamp sentAt}) {
    final sentAtDateTime = sentAt.toDate();
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Card(
        elevation: 1,
        child: ListTile(
          horizontalTitleGap: 15,
          minVerticalPadding: 10,
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(imageURL, scale: 1),
            radius: 25,
          ),
          onTap: () {
            // Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(builder: (context) => MessagingScreen()));
          },
          title: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(latestMessage),
          trailing: Column(
            children: [
              //time of message received
              Text(
                '${sentAtDateTime.hour} : ${sentAtDateTime.second}',
                style: TextStyle(color: Colors.grey.shade900),
              ),
              const SizedBox(height: 5),
              // Container(
              //   width: 20,
              //   height: 20,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: Colors.red,
              //   ),
              //   child: const Text(
              //     '3',
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   alignment: Alignment.center,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
