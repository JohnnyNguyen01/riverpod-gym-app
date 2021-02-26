import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/domain/camera_services/image_picker.dart';

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

  void getImageFromCamera() async {
    state = AsyncData({_deafultImgPath: _defaultImg});
    File imagePath = await imagePickerService.getNewAvatarImageFromCamera();
    state = AsyncData({imagePath.path: FileImage(imagePath)});
  }
}
