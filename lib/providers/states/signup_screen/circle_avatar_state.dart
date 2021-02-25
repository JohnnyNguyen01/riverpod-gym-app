import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/domain/camera_services/image_picker.dart';

final circleAvatarStateProvider = StateNotifierProvider<CircleAvatarState>(
    (ref) => CircleAvatarState(ref.read));

class CircleAvatarState extends StateNotifier<AsyncValue<ImageProvider>> {
  CircleAvatarState(this.read) : super(AsyncLoading()) {
    _init();
  }

  final Reader read;
  ImagePickerService imagePickerService;
  final _defaultImg = AsyncData(AssetImage('assets/images/Missing_avatar.png'));

  void _init() async {
    state = _defaultImg;
    imagePickerService = read(imagePickerServiceProvider);
  }

  void getImageFromCamera() async {
    state = _defaultImg;
    File imagePath = await imagePickerService.getNewAvatarImageFromCamera();
    state = AsyncData(FileImage(imagePath));
  }
}
