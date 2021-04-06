import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class MessageContact extends Equatable {
  final String clientID;
  final String client;
  final String latestMessage;
  final String coach;
  final Timestamp sentAt;
  final String sentBy;
  final String coachImageURL;
  final String coachID;
  final String chatRoomID;

  MessageContact(
      {@required this.latestMessage,
      @required this.coach,
      @required this.coachID,
      @required this.sentAt,
      @required this.coachImageURL,
      @required this.sentBy,
      @required this.clientID,
      @required this.client,
      @required this.chatRoomID});

  MessageContact.init()
      : this.client = '',
        this.clientID = '',
        this.coach = '',
        this.coachID = '',
        this.coachImageURL = '',
        this.latestMessage = '',
        this.sentAt = null,
        this.chatRoomID = '',
        this.sentBy = '';

  MessageContact.fromDocumentSnapshot(Map<String, dynamic> snapshot)
      : this.latestMessage = snapshot['latestMessage'],
        this.coach = snapshot['coach'],
        this.coachID = snapshot['coachID'],
        this.sentAt = snapshot['sentAt'],
        this.coachImageURL = snapshot['coachImageURL'],
        this.clientID = snapshot['clientID'],
        this.client = snapshot['client'],
        this.chatRoomID = snapshot['chatRoomID'],
        this.sentBy = snapshot['sentBy'];

  Map<String, dynamic> toMap() {
    return {
      'latestMessage': this.latestMessage,
      'coach': this.coach,
      'coachID': this.coachID,
      'sentAt': this.sentAt,
      'coachImageURL': this.coachImageURL,
      'clientID': this.clientID,
      'client': this.client,
      'chatRoomID': this.chatRoomID,
      'sentBy': this.sentBy
    };
  }

  MessageContact copyWith(
      {String latestMessage,
      String coach,
      String coachID,
      Timestamp sentAt,
      String coachImageURL,
      String clientID,
      String client,
      String chatRoomID,
      String sentBy}) {
    return MessageContact(
        latestMessage: latestMessage ?? this.latestMessage,
        coach: coach ?? this.coach,
        coachID: coachID ?? this.coachID,
        sentAt: sentAt ?? this.sentAt,
        coachImageURL: coachImageURL ?? this.coachImageURL,
        client: client ?? this.client,
        clientID: clientID ?? this.clientID,
        chatRoomID: chatRoomID ?? this.chatRoomID,
        sentBy: sentBy ?? this.sentBy);
  }

  @override
  List<Object> get props => [
        latestMessage,
        coach,
        coachID,
        sentAt,
        coachImageURL,
        client,
        clientID,
        chatRoomID,
        sentBy
      ];
}
