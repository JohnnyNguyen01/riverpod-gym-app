import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/camera_services/image_picker.dart';

final photoDialogBoxControllerProvider =
    Provider<PhotoDialogBoxController>((ref) {
  return PhotoDialogBoxController(ref.read);
});

class PhotoDialogBoxController {
  final Reader read;

  PhotoDialogBoxController(this.read);

  void handleCameraBtn() async {
    await read(imagePickerServiceProvider).getNewAvatarImageFromCamera();
  }

  void handleCancelBtn(BuildContext context) {
    Navigator.of(context).pop();
  }
}
