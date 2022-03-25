import 'dart:async';

import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';

import '../../../services/sound_service/sound_service.dart';

class AnnotationAudioController extends ChangeNotifier
    implements ReassembleHandler {
  AnnotationAudioController({
    required SoundService soundService,
  }) : _soundService = soundService;

  PlayerState playerState = PlayerState.isStopped;

  final SoundService _soundService;
  StreamController<PlaybackDisposition?> onProgress =
      StreamController<PlaybackDisposition>.broadcast();

  Future<void> sessionAudio() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  Future<void> openAudioSessionPlayer() async {
   await _soundService.openAudioSessionPlayer();
  }

  Future<void> closeAudioSessionPlayer() async {
    await _soundService.closeAudioSessionPlayer();
  }

  Future<void> playSound({required String path}) async {
    await _soundService.playSound(path);
    await getPlayerState();
  }

  Stream<PlaybackDisposition>? get progressPlayerSound {
    return _soundService.onProgress;
  }

  Future<void> setDurationUpdateProgress() async {
    await _soundService.setDurationUpdateOnProgress();
  }

  Future<void> seekToPlayer({required Duration duration}) async {
    await _soundService.seekToPlayer(duration: duration);
  }

  Future<void> pauseSong()async{
    await _soundService.pauseSound();
    await getPlayerState();
  }
  Future<void> resumeSong()async{
    await _soundService.resumeSound();
    await getPlayerState();
  }

  Future<void> getPlayerState()async{
    playerState = await _soundService.getPlayerState();
    notifyListeners();
  }

  @override
  void reassemble() {
    debugPrint('did not hot-reload PlayerSoundController ');
  }
}
