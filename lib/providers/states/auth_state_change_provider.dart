import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/firebase_auth_repo.dart';

final authStateChangesProvider = StreamProvider<User>(
    (ref) => ref.watch(firebaseAuthRepoProvider).authStateChanges());
