import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginStateProvider = StateNotifierProvider<LoginState>((ref) {
  return LoginState();
});

class LoginState extends StateNotifier<AsyncValue<bool>> {
  LoginState() : super(AsyncData(false));

  void changeLoginState(bool newBool) {
    // bool newState = !state.data.value;
    state = AsyncData(newBool);
  }
}
