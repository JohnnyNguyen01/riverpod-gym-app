import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/models/coach_model.dart';
import 'package:gym_tracker/domain/models/models.dart';
import 'package:gym_tracker/domain/storage/firebase_firestore_service.dart';

final coachStateProvider = StateNotifierProvider<CoachState>((ref) {
  return CoachState(read: ref.read);
});

class CoachState extends StateNotifier<AsyncValue<Coach>> {
  CoachState({@required this.read}) : super(AsyncData(Coach.initState()));

  final Reader read;

  void setCoachFromDatabase({@required String coachUID}) async {
    try {
      state = AsyncLoading();
      Coach coach = await read(databaseProvider).getCoach(coachUid: coachUID);
      state = AsyncData(coach);
    } catch (e) {
      throw Failure(error: "Error", message: e.toString());
    }
  }
}
