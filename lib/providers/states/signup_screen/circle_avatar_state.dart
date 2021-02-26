import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/domain/camera_services/image_picker.dart';
import 'package:gym_tracker/domain/storage/firebase_cloud_storage_service.dart';

final circleAvatarStateProvider = StateNotifierProvider<CircleAvatarState>(
    (ref) => CircleAvatarState(ref.read));

class CircleAvatarState
    extends StateNotifier<AsyncValue<Map<String, ImageProvider>>> {
  CircleAvatarState(this.read) : super(AsyncLoading()) {
    _init();
  }

  final Reader read;
  ImagePickerService imagePickerService;
  final _defaultImg = AssetImage('assets/images/Missing_avatar.png');
  final _deafultImgPath = 'assets/images/Missing_avatar.png';

  void _init() async {
    state = AsyncData({_deafultImgPath: _defaultImg});
    imagePickerService = read(imagePickerServiceProvider);
  }

  ///Capture an image from the camera and update all circle avatar states to new
  ///image.
  void getImageFromCamera() async {
    state = AsyncData({_deafultImgPath: _defaultImg});
    File imagePath = await imagePickerService.getNewAvatarImageFromCamera();
    state = AsyncData({imagePath.path: FileImage(imagePath)});
  }

  ///Takes in a string uid and returns a network image from Firebase Storage.
  void getImageFromWebStorage(String uid) async {
    state = AsyncData({_deafultImgPath: _defaultImg});
    String photoURL =
        await read(storageCloudService).getUserProfilePhotoUrl(uid);
    state = AsyncData({photoURL: NetworkImage(photoURL)});
  }

  ///Reset the state the default empty profile image.
  void resetStateToDefault() async {
    state = AsyncData({_deafultImgPath: _defaultImg});
  }
}
