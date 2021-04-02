import 'package:flutter/material.dart';

import '../../../routing/app_router.dart';
import 'widgets/video_player.dart';

class InitialAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //todo: Uncomment below when deploying app. Doing this to stop emulator lag.
          _BuildVideoPlayer(),
          _BuildOpacityContainer(),
          _BuildFormCard()
        ],
      ),
    );
  }
}

class _BuildFormCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Card(
          color: Colors.white.withOpacity(0.55),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Image.asset('assets/images/logo.png'),
              SizedBox(height: 20),
              _BuildButtonGroup(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildOpacityContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.34)),
    );
  }
}

class _BuildButtonGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.authSignUpScreen);
                },
                child: Text("Sign Up"),
              ),
            ),
          ),
          SizedBox(width: 15),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.authLoginScreen);
            },
            child: Text(
              "I already have an account",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: unused_element
class _BuildVideoPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: CustomVideoPlayer('assets/videos/homepage_video.mp4'),
        ),
      ),
    );
  }
}
