import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/states/user_state_provider.dart';

final storageCloudService = Provider<FirebaseStorageService>((ref) {
  return FirebaseStorageService(read: ref.read);
});

class FirebaseStorageService {
  FirebaseStorage _storage;
  final Reader read;

  FirebaseStorageService({Reader read})
      : _storage = FirebaseStorage.instance,
        this.read = read;

  ///Upload a new user profile photo to firebase storage in the [user_images]
  ///storage folder in the main bucket, labelled by their uid via the userStateController.
  Future<String> addNewUserProfilephoto(File imageFile, String uid) async {
    try {
      //reference to location of user profile image id
      final ref = _storage.ref().child('profile_pictures').child(uid);
      await ref.putFile(imageFile);

      return 'storage operation successful';
    } catch (e) {
      return e.toString();
    }
  }

  ///Retrieve the link to a user's profile photo using their 'uid'
  Future<String> getUserProfilePhotoUrl(String uid) async {
    return await _storage
        .ref()
        .child('profile_pictures')
        .child(uid)
        .getDownloadURL();
  }
}
