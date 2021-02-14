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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _BuildHeading(),
              SizedBox(height: 70),
              _BuildButtonGroup(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Welcome!",
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              //todo: remove and refactor routing
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (c) => SignUpScreen()));
            },
            child: Text("Sign Up"),
          ),
          SizedBox(width: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (c) => LoginScreen()));
            },
            child: Text("Login"),
          )
        ],
      ),
    );
  }
}

class _BuildVideoPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomVideoPlayer('assets/videos/initial_screen.mp4');
  }
}
