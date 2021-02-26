import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../authentication/models/user_model.dart';

final databaseProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(read: ref.read);
});

class FirestoreService {
  final Reader read;
  FirebaseFirestore firestore;

  FirestoreService({this.read}) {
    firestore = firestore ?? FirebaseFirestore.instance;
  }

  Future<void> addNewUser(UserModel user) async {
    CollectionReference users = firestore.collection('users');
    try {
      await users.add({
        'email': user.email,
        'username': user.userName,
        'uid': user.uid,
        'image_url': user.profileImageURL
      });
    } catch (e) {}
  }
}
