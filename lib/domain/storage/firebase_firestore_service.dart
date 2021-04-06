import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/utils/utils.dart';

import '../models/models.dart';

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

  ///Set the latest chatroom information for a particular chatroom.
  Future<void> setLatestChatRoomInformation(MessageContact roomInfo) async {}

  ///Retrieves a `Coach` object from firestore via a specified `uid`
  Future<Coach> getCoach({@required String coachUid}) async {
    CollectionReference coachesCollection =
        _firestore.collection(Paths.coaches);

    try {
      final coachSnapshot = await coachesCollection.doc(coachUid).get();
      return Coach.fromDatabase(coachSnapshot.data());
    } on PlatformException catch (e) {
      throw Failure(error: e.code, message: e.message);
    } catch (e) {
      throw Failure(error: "", message: e.toString());
    }
  }

  ///Adds a new doc to `user_entries` in firestore using a user's `uid`. This will
  ///contain a collection of all their entered workout data.
  Future<void> uploadUserWorkoutValues(
      {@required WorkoutUserValuesModel model, @required String uid}) async {
    CollectionReference userEntries = _firestore.collection(Paths.userEntries);
    try {
      await userEntries
          .doc(uid)
          .collection(Paths.userWorkoutDates)
          .doc(DateTime.now().toString())
          .set({
        'workoutNote': model.workoutNote,
        'completedAt': model.completedAt,
        'startedAt': model.startedAt,
        'workoutCompletionTime': model.workoutCompletionTime,
        'filledOutExercises': model.filledOutExercisesForFirestore()
      });
    } on PlatformException catch (e) {
      throw Failure(error: e.code, message: e.message);
    } catch (e) {
      throw Failure(error: "Generic", message: e.toString());
    }
  }

  // Returns a stream of a specific chat room between a coach and client.
  Stream<List<Message>> getChatRoomStream(
      {@required String coachUID, @required clientUID}) {
    final streamSnapshot = _firestore
        .collection(Paths.chatRooms)
        .doc('$coachUID\_$clientUID')
        .collection(Paths.messages)
        .orderBy('sentAt', descending: true)
        .snapshots()
        .asBroadcastStream();

    Stream<List<Message>> messageStream = streamSnapshot.map((event) {
      List<Message> messages = [];
      var allMessages = event.docs;
      for (var doc in allMessages) {
        print(allMessages.length);
        messages.add(Message.fromDocSnapshot(doc.data()));
      }
      return messages;
    });

    return messageStream.asBroadcastStream();
  }

  // Add messages to chat room between a specific coach and client
  Future<void> addMessageToChatRoom(
      {@required String coachUID,
      @required String clientUID,
      @required Message message}) async {
    final chatRoomDoc =
        _firestore.collection(Paths.chatRooms).doc('$coachUID\_$clientUID');
    final messagesCollection = chatRoomDoc.collection(Paths.messages);
    messagesCollection.add(message.toMap());
  }

  ///Retrieves a list of all of this client's chatrooms as a `MessageConact` list
  ///via their uid.
  Future<List<MessageContact>> getChatRooms({String uid}) async {
    final chatRooms = _firestore
        .collection(Paths.chatRooms)
        .where('clientID', isEqualTo: uid)
        .get();
    try {
      List<MessageContact> chatList = [];
      final snapshotList = await chatRooms;
      for (var snapshot in snapshotList.docs) {
        chatList.add(MessageContact.fromDocumentSnapshot(snapshot.data()));
      }
      return chatList;
    } on PlatformException catch (e) {
      throw Failure(error: e.code, message: e.message);
    } catch (e) {
      throw Failure(error: "Error", message: e.toString());
    }
  }

  Future<String> setUserName(String uid, String newName) async {
    CollectionReference users = _firestore.collection(Paths.users);
    try {
      await users.doc(uid).update({'username': newName});
      return "Success";
    } on FirebaseException catch (e) {
      log(e.message);
      return e.message;
    }
  }

  ///Retrieve a user's details as a [UserModel] object from firestore.
  Future<UserModel> getUser(String uid) async {
    CollectionReference users = _firestore.collection('users');
    final userSnapshot = await users.doc(uid).get().catchError((e) {
      print(e);
      return null;
    });
    UserModel user = UserModel.fromDocumentSnapshot(userSnapshot.data());
    return user;
  }

  ///Returns the Workout for the specified uid and timestamp.
  ///todo: Check if there's a more efficient way of doing this
  Future<Workout> getUserWorkout(String uid, DateTime dateTime) async {
    Workout workout = Workout.empty();
    CollectionReference workoutPlan = _firestore.collection("workout_plan");

    //get latest workout snapshot for specified uid
    final workoutDocRef = await workoutPlan
        .where("clientID", isEqualTo: uid)
        .orderBy("createdAt", descending: false)
        .limit(1)
        .get();

    //get workout document
    final workoutDoc = workoutDocRef.docs[0];

    //get into day's collection
    final workoutDays = workoutDoc.reference.collection("days");
    //snapshot containing list of all workout "days" documents
    final snapshot = await workoutDays.get();
    //loop through each doc and check for a matching DateTime
    snapshot.docs.forEach((doc) {
      var docSnapshot = doc.data();
      List dates = docSnapshot["dates"];
      dates.forEach((timestamp) {
        DateTime docDate = DateTime.parse(timestamp.toDate().toString());
        if (docDate == dateTime) {
          workout = Workout.fromWorkoutPlan(docSnapshot);
        }
      });
    });

    return workout;
  }
}
