import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class MessageContact extends Equatable {
  final String docID;
  final String latestMessage;
  final String coach;
  final Timestamp sentAt;

  MessageContact(
      {@required this.docID,
      @required this.latestMessage,
      @required this.coach,
      @required this.sentAt});

  MessageContact.fromDocumentSnapshot(Map<String, dynamic> snapshot)
      : this.docID = snapshot['docID'],
        this.latestMessage = snapshot['latest_message'],
        this.coach = snapshot['coach'],
        this.sentAt = snapshot['sentAt'];

  MessageContact copyWith(
      {String docID, String latestMessage, String coach, Timestamp sentAt}) {
    return MessageContact(
        docID: docID ?? this.docID,
        latestMessage: latestMessage ?? this.latestMessage,
        coach: coach ?? this.coach,
        sentAt: sentAt ?? this.sentAt);
  }

  @override
  List<Object> get props => [docID, latestMessage, coach, sentAt];
}
