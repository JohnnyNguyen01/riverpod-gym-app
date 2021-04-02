import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/camera_services/image_picker.dart';
import 'package:gym_tracker/states/states.dart';
import 'photo_dialog_box_controller.dart';

class PhotoDialogBox extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _controller = watch(photoDialogBoxControllerProvider);
    final _imgPickerProvider = watch(imagePickerServiceProvider);

    return Stack(clipBehavior: Clip.none, children: [
      AlertDialog(
        title: Text("Upload a photo"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Would you like to upload a photo from your camera, or gallery?'),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _BuildCameraButton(
                  onPressed: () =>
                      _imgPickerProvider.getNewAvatarImageFromCamera(),
                ),
                SizedBox(width: 10),
                _BuildGalleryButton(),
              ],
            ),
            _BuildCancelButton(
              onPressed: () => _controller.handleCancelBtn(context),
            )
          ],
        ),
      ),
      _BuildCircleAvatar(),
    ]);
  }
}

class _BuildCircleAvatar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _circleAvatarState = watch(circleAvatarStateProvider.state);

    final _mediaQuerySize = MediaQuery.of(context).size;
    return Positioned(
      left: _mediaQuerySize.width / 2.6,
      top: _mediaQuerySize.height / 4.35,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: _circleAvatarState.data.value.entries.first.value,
      ),
    );
  }
}

class _BuildCameraButton extends StatelessWidget {
  final Function onPressed;

  _BuildCameraButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Camera'),
      onPressed: () => onPressed(),
    );
  }
}

class _BuildGalleryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Gallery'),
      onPressed: () {},
    );
  }
}

class _BuildCancelButton extends StatelessWidget {
  final Function onPressed;

  const _BuildCancelButton({@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text("Cancel"),
        onPressed: onPressed,
      ),
    );
  }
}
