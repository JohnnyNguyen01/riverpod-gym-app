import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imagePickerServiceProvider = Provider<ImagePickerService>((ref) {
  return ImagePickerService(ref.read);
});

class ImagePickerService {
  final Reader read;

  final _imagePicker = ImagePicker();

  ImagePickerService(this.read);

  Future<File> getNewAvatarImageFromCamera() async {
    File image;
    final _pickedFile = await _imagePicker.getImage(source: ImageSource.camera);
    _pickedFile != null ? image = File(_pickedFile.path) : image = null;
    return image;
  }
}
