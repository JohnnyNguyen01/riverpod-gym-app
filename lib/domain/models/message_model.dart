import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Message extends Equatable {
  final String message;
  final DateTime sentAt;
  final String sentBy;
  final String profileImageURL;

  Message(
      {@required this.message,
      @required this.sentAt,
      @required this.sentBy,
      @required this.profileImageURL});

  Message.fromDocSnapshot(Map<String, dynamic> snapshot)
      : message = snapshot['message'],
        sentAt = snapshot['sentAt'].toDate(),
        sentBy = snapshot['sentBy'],
        profileImageURL = snapshot['profileImageURL'];

  Map<String, dynamic> toMap() {
    return {
      'message': this.message,
      'sentAt': Timestamp.fromDate(this.sentAt),
      'sentBy': this.sentBy,
      'profileImageURL': this.profileImageURL
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message, sentAt, sentBy, profileImageURL];
}
