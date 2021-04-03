import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/storage/firebase_firestore_service.dart';

import '../../../domain/authentication/firebase_auth_repo.dart';
import 'package:gym_tracker/states/states.dart';
import '../../home/home_screen.dart';
import '../auth_screens/initial_auth_screen.dart';

class AuthWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _authProvider = watch(firebaseAuthRepoProvider);

    return StreamBuilder(
      stream: _authProvider.getCurrentSignedInUserStream(),
      builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
        if (userSnapshot.data == null) {
          return InitialAuthScreen();
        } else {
          setUser(context);
          return HomeScreen();
        }
      },
    );
  }

  //todo: See if i can fix this up and separate logic
  void setUser(BuildContext context) async {
    context.read(userStateController).setCurrentUserFromAuthRepo();
    final user = await context
        .read(databaseProvider)
        .getUser(context.read(userStateController.state).data.value.uid);
    context.read(userStateController).setUserName(user.userName);
    context.read(circleAvatarStateProvider).getImageFromWebStorage(user.uid);
  }
}
