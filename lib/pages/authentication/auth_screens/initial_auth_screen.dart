import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/pages/authentication/auth_screens/login/login_screen.dart';
import 'package:gym_tracker/pages/authentication/auth_screens/signup/signup_screen.dart';
import 'package:gym_tracker/pages/authentication/auth_screens/widgets/video_player.dart';

class InitialAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                  //todo: remove and refactor routing
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => SignUpScreen()));
                },
                child: Text("Sign Up"),
              ),
            ),
          ),
          SizedBox(width: 15),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (c) => LoginScreen()));
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
