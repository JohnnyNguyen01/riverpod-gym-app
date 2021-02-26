import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../authentication/models/user_model.dart';

final databaseProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(read: ref.read);
});

class FirestoreService {
  final Reader read;
  FirebaseFirestore _firestore;

  FirestoreService({this.read}) {
    _firestore = _firestore ?? FirebaseFirestore.instance;
  }

  ///Add a new user to the users collection in firestore.
  ///Creates an new doc using their uid
  Future<void> addNewUser(UserModel user) async {
    CollectionReference users = _firestore.collection('users');
    try {
      await users.doc(user.uid).set({
        'email': user.email,
        'username': user.userName,
        'uid': user.uid,
        'image_url': user.profileImageURL
      });
    } catch (e) {
      log(e);
    }
  }

  Future<String> setUserName(String uid, String newName) async {
    CollectionReference users = _firestore.collection('users');
    try {
      await users.doc(uid).update({'username': newName});
      return "Success";
    } on FirebaseException catch (e) {
      log(e.message);
      return e.message;
    }
  }
}
