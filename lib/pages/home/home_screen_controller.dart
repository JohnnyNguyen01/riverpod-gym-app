import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeScreenController = Provider<HomeScreenController>((ref) {
  return HomeScreenController();
});

class HomeScreenController {}
