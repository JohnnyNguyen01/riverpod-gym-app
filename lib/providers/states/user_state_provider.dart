import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/auth_repository.dart';
import 'package:gym_tracker/domain/authentication/firebase_auth_repo.dart';
import 'package:gym_tracker/domain/authentication/models/user_model.dart';

final userStateController = StateNotifierProvider<UserStateAsyncNotifier>(
    (ref) => UserStateAsyncNotifier(ref.read));

class UserStateAsyncNotifier extends StateNotifier<AsyncValue<UserModel>> {
  //ref reader to read database provider
  final Reader read;
  AuthRepository _authRepo;

  UserStateAsyncNotifier(this.read) : super(AsyncLoading()) {
    _init();
  }

  /*
   * There are 3 main types of async values.
   * AsyncLoading - define at beginning of each method to indicate loading state 
   * AsyncData - used when returning new immutable state object
   * AsyncError - used when an error is returned
   */

  void _init() async {
    state = AsyncData(UserModel.initValue());
    _authRepo = read(firebaseAuthRepoProvider);
  }

  //add methods for manipulating state
  Future<String> setCurrentUserFromAuthRepo() async {
    try {
      state = AsyncValue.data(UserModel.fromAuthAndStorageProviders(_authRepo));
      return "getCurrentuser() success";
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<void> removeCurrentUser() async {
    state = AsyncLoading();
    state = AsyncData(UserModel.initValue());
  }
}
