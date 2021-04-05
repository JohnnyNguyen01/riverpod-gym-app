import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/pages/messaging/messaging_screen.dart';
import 'package:gym_tracker/pages/widgets/bottom_nav_bar/custom_bottom_navbar.dart';
import 'package:gym_tracker/states/states.dart';

class MessagingContactsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader read) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildContactCard(context: context);
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

  Widget _buildContactCard({@required BuildContext context}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Card(
        elevation: 1,
        child: ListTile(
          horizontalTitleGap: 15,
          minVerticalPadding: 10,
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                'https://picsum.photos/200/300',
                scale: 1), //NetworkImage('https://picsum.photos/200/300'),
            radius: 25,
          ),
          onTap: () {
            print(context.read(userStateController.state).data.value.coachUID);
            // Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(builder: (context) => MessagingScreen()));
          },
          title: Text(
            'Amir Fazeli',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Aye bro, please call me when you can"),
          trailing: Column(
            children: [
              //time of message received
              Text(
                '10:31 AM',
                style: TextStyle(color: Colors.grey.shade900),
              ),
              const SizedBox(height: 5),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: const Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
                alignment: Alignment.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
