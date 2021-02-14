import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/models/user_model.dart';

final currentUserStateProvider =
    StateProvider<UserModel>((ref) => UserModel.initValue());

class UserState {}
