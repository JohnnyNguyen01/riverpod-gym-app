import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';

class SoundPlayer {
  /// Play an asset sound file.
  static void playAssetSound({@required String asset}) {
    final instance = AssetsAudioPlayer();
    instance.open(Audio(asset));
    instance.dispose();
  }
}
