import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/firebase_auth_repo.dart';
import 'package:gym_tracker/providers/states/user_state_provider.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUserState = watch(userStateController);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => print(currentUserState.state),
              child: Text("get current user state"),
            ),
            ElevatedButton(
                onPressed: () {
                  context.read(firebaseAuthRepoProvider).logOut();
                },
                child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
