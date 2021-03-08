import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerTile extends StatefulWidget {
  final String url;

  const YoutubePlayerTile({this.url});

  @override
  _YoutubePlayerTileState createState() => _YoutubePlayerTileState();
}

class _YoutubePlayerTileState extends State<YoutubePlayerTile> {
  String videoID;
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    videoID = YoutubePlayer.convertUrlToId(widget.url);
    _controller = _initialiseYoutubeController();
  }

  YoutubePlayerController _initialiseYoutubeController() {
    return YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoID),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: _controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
