import 'package:flutter/foundation.dart';

import 'models/user_model.dart';

abstract class AuthRepository {
  Future<String> loginWithEmailAndPassword(
      {@required String email, @required String password});

  Future<String> logOut();

  Future<String> signUpWithEmailAndPassword(
      {@required String email, @required String password});

  Future<String> createNewUserInDatabase(
      {@required String username,
      @required String uid,
      @required String email});

  Stream getCurrentSignedInUserStream();

  String get uid;

  String get userName;

  String get email;

  Future<UserModel> getCurrentUserDetails();
}
