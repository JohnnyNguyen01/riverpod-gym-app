import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final homeScreenControllerProvider = Provider<HomeScreenController>((ref) {
  return HomeScreenController(ref.read);
});

class HomeScreenController {
  final Reader read;

  HomeScreenController(this.read);

  //todo: move to homeController
  void showModalBottomSheet(GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState.showBottomSheet(
      (context) => Container(
        height: MediaQuery.of(context).size.height / 1.25,
        color: Colors.blueAccent,
      ),
    );
  }
}
