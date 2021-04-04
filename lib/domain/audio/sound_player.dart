import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gym_tracker/domain/models/models.dart';

class SoundPlayer {
  /// Play an asset sound file.
  static void playAssetSound({@required String asset}) {
    final instance = AssetsAudioPlayer();
    try {
      instance.open(Audio(asset));
    } on PlatformException catch (e) {
      throw Failure(error: e.code, message: e.message);
    } catch (e) {
      print(e.toString());
    }
    instance.dispose();
  }
}
