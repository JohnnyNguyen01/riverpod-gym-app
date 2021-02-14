import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/auth_repository.dart';
import 'package:gym_tracker/domain/authentication/models/user_model.dart';

final firebaseAuthRepoProvider =
    Provider.autoDispose<FirebaseAuthRepo>((ref) => FirebaseAuthRepo());

class FirebaseAuthRepo implements AuthRepository {
  final FirebaseAuth _authInstance;
  final FirebaseFirestore _dbInstance;

  FirebaseAuthRepo({FirebaseAuth authInstance, FirebaseFirestore dbInstance})
      : _authInstance = authInstance ?? FirebaseAuth.instance,
        _dbInstance = dbInstance ?? FirebaseFirestore.instance;

  @override
  Future<String> signUpWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      await _authInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Sign in successful';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Future<String> loginWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      await _authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      return 'login with email and password successful';
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return Future.error(e.message);
    }
  }

  @override
  Future<String> logOut() async {
    try {
      await _authInstance.signOut();
      return 'sign out successful';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Future<String> createNewUserInDatabase(
      {String username, String uid, String email}) async {
    try {
      //todo change users_test collection
      _dbInstance
          .collection('users_test')
          .add({'username': username, 'uid': uid, 'email': email});
      return 'new user succesfully created!';
    } catch (e) {
      return e.message;
    }
  }

  @override
  Stream<User> getCurrentSignedInUserStream() {
    return _authInstance.authStateChanges();
  }

  @override
  Future<UserModel> getCurrentUserDetails() async {
    return UserModel(
        uid: _authInstance.currentUser.uid,
        userName: _authInstance.currentUser.displayName);
  }

  @override
  String get uid => _authInstance.currentUser.uid;

  @override
  String get userName => _authInstance.currentUser.displayName;
}
