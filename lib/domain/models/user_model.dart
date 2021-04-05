import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../authentication/auth_repository.dart';

class UserModel extends Equatable {
  String userName;
  String uid;
  String email;
  String profileImageURL;
  String coachUID;

  UserModel(
      {@required this.userName,
      @required this.uid,
      @required this.email,
      @required this.profileImageURL,
      @required this.coachUID});

  UserModel.fromDocumentSnapshot(Map<String, dynamic> json) {
    this.uid = json['uid'];
    this.userName = json['username'];
    this.email = json['email'];
    this.profileImageURL = json['image_url'];
    this.coachUID = json['coachUID'];
  }

  ///Creates a new [UserModel] object with empty strings to counter null values
  UserModel.initValue() {
    this.userName = '';
    this.uid = '';
    this.profileImageURL = '';
    this.email = '';
    this.coachUID = '';
  }

  UserModel.fromAuthAndStorageProviders(AuthRepository authProvider) {
    this.uid = authProvider.uid;
    this.userName = authProvider.userName;
    this.email = authProvider.email;
    this.profileImageURL = '';
    this.coachUID = "";
  }

  UserModel copyWith(
          {String userName,
          String uid,
          String email,
          String profileImageURL,
          String currentCoach}) =>
      UserModel(
          userName: userName ?? this.userName,
          uid: uid ?? this.uid,
          email: email ?? this.email,
          profileImageURL: profileImageURL ?? this.profileImageURL,
          coachUID: currentCoach ?? this.coachUID);

  // @override
  // String toString() {
  //   return 'username: $userName || email: $email || uid: $uid || image_irl: $profileImageURL';
  // }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [userName, uid, email, profileImageURL];
}
