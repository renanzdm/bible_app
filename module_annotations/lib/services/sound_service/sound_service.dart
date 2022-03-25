

import 'package:commons_dependencies/main.dart';

abstract class SoundService{
  Future<void> setDurationUpdateOnProgress({Duration duration= const Duration(milliseconds: 100)});

  Future<void> playSound(String pathAudio);
  Future<void> stopSound();
  Future<void> pauseSound();
  Future<void> resumeSound();
  bool  get isPlaying;
  Future<PlayerState> getPlayerState();

  Stream<PlaybackDisposition>? get onProgress;
  Future<void> openAudioSessionPlayer();
  Future<void> closeAudioSessionPlayer();
  Future<void> seekToPlayer({required Duration duration});

}