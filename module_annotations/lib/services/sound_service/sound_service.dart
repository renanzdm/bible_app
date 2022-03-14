

import 'package:commons_dependencies/main.dart';

abstract class SoundService{
  Future<void> playSound(String pathAudio);
  Future<void> stopSound();
  Future<void> pauseSound();
  Stream<PlaybackDisposition>? onProgress();
  Future<void> openAudioSessionPlayer();
  Future<void> closeAudioSessionPlayer();

}