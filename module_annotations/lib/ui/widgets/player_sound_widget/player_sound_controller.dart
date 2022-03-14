import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';

import '../../../services/sound_service/sound_service.dart';

class PlayerSoundController extends ChangeNotifier
    implements ReassembleHandler {
  PlayerSoundController({
    required SoundService soundService,
  }) : _soundService = soundService {
    openAudioSessionPlayer();
    sessionAudio();
  }

  final SoundService _soundService;

  Future<void> sessionAudio() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  Future<void> openAudioSessionPlayer() async {
    await _soundService.openAudioSessionPlayer();
  }

  Future<void> closeAudioSessionPlayer() async {
    return await _soundService.closeAudioSessionPlayer();
  }

  Future<void> playSound() async {
    await _soundService.playSound(
        '/data/data/com.example.base_app/cache/annotations_audio_5.aac');
  }

  @override
  void reassemble() {
    debugPrint('did not hot-reload PlayerSoundController ');
  }
}
