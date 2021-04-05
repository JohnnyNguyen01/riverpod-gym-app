import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Coach extends Equatable {
  final String name;
  final String email;
  final String uid;
  final String imageURL;

  Coach(
      {@required this.email,
      @required this.name,
      @required this.uid,
      @required this.imageURL});

  Coach.initState()
      : this.name = "",
        this.email = "",
        this.uid = "",
        this.imageURL = "";

  Coach copyWith({String name, String email, String uid, String imageURL}) {
    return Coach(
        name: name ?? this.name,
        email: email ?? this.email,
        uid: uid ?? this.uid,
        imageURL: imageURL ?? this.imageURL);
  }

  Coach.fromDatabase(Map<String, dynamic> json)
      : this.name = json['name'],
        this.email = json['email'],
        this.uid = json['uid'],
        this.imageURL = json['image_url'];

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, email, uid];
}
