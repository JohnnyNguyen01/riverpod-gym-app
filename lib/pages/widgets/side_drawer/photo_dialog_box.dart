import 'package:flutter/material.dart';

class PhotoDialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                _BuildCameraButton(),
                SizedBox(width: 10),
                _BuildGalleryButton(),
              ],
            ),
            _BuildCancelButton()
          ],
        ),
      ),
      _BuildCircleAvatar(),
    ]);
  }
}

class _BuildCircleAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuerySize = MediaQuery.of(context).size;
    return Positioned(
      left: _mediaQuerySize.width / 2.6,
      top: _mediaQuerySize.height / 4.35,
      child: CircleAvatar(
        radius: 50,
      ),
    );
  }
}

class _BuildCameraButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Camera'),
      onPressed: () {},
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
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text("Cancel"),
        onPressed: () {},
      ),
    );
  }
}
