import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  ///The location of the video file to be played.
  final String videoLocation;

  CustomVideoPlayer(this.videoLocation);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.videoLocation)
      ..initialize().then((_) => setState(() {}));
    _videoController.setLooping(true);
    _videoController.setVolume(0.0);
    _videoController.play();
  }

  @override
  Widget build(BuildContext context) {
    return _videoController.value.initialized
        ? SizedBox(
            width: _videoController.value.size?.width ?? 0,
            height: _videoController.value.size?.height ?? 0,
            child: VideoPlayer(_videoController))
        : Container(child: Text("Video Error"));
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
}
