import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/firebase_auth_repo.dart';
import 'package:gym_tracker/domain/authentication/models/user_model.dart';
import 'package:gym_tracker/pages/authentication/auth_screens/initial_auth_screen.dart';
import 'package:gym_tracker/pages/home/home_screen.dart';
import 'package:gym_tracker/providers/states/user_state_provider.dart';

class AuthWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _authProvider = watch(firebaseAuthRepoProvider);

    return StreamBuilder(
      stream: _authProvider.getCurrentSignedInUserStream(),
      builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
        if (userSnapshot.data == null) {
          return InitialAuthScreen();
        } else
          context.read(userStateController).setCurrentUserFromAuthRepo();
        return HomeScreen();
      },
    );
  }
}
