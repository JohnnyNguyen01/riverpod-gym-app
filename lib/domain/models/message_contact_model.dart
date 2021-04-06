import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class MessageContact extends Equatable {
  final String docID;
  final String clientID;
  final String client;
  final String latestMessage;
  final String coach;
  final Timestamp sentAt;
  final String coachImagURL;
  final String coachID;

  MessageContact(
      {@required this.docID,
      @required this.latestMessage,
      @required this.coach,
      @required this.coachID,
      @required this.sentAt,
      @required this.coachImagURL,
      @required this.clientID,
      @required this.client});

  MessageContact.init()
      : this.client = '',
        this.clientID = '',
        this.coach = '',
        this.coachID = '',
        this.coachImagURL = '',
        this.docID = '',
        this.latestMessage = '',
        this.sentAt = null;

  MessageContact.fromDocumentSnapshot(Map<String, dynamic> snapshot)
      : this.docID = snapshot['docID'],
        this.latestMessage = snapshot['latestMessage'],
        this.coach = snapshot['coach'],
        this.coachID = snapshot['coachID'],
        this.sentAt = snapshot['sentAt'],
        this.coachImagURL = snapshot['coachImageURL'],
        this.clientID = snapshot['clientID'],
        this.client = snapshot['client'];

  MessageContact copyWith(
      {String docID,
      String latestMessage,
      String coach,
      String coachID,
      Timestamp sentAt,
      String coachImageURL,
      String clientID,
      String client}) {
    return MessageContact(
        docID: docID ?? this.docID,
        latestMessage: latestMessage ?? this.latestMessage,
        coach: coach ?? this.coach,
        coachID: coachID ?? this.coachID,
        sentAt: sentAt ?? this.sentAt,
        coachImagURL: coachImageURL ?? this.coachImagURL,
        client: client ?? this.client,
        clientID: clientID ?? this.clientID);
  }

  @override
  List<Object> get props => [
        docID,
        latestMessage,
        coach,
        coachID,
        sentAt,
        coachImagURL,
        client,
        clientID
      ];
}
