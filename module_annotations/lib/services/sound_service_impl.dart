

import 'package:commons_dependencies/main.dart';
import 'package:module_annotations/services/sound_service.dart';

class SoundServiceImpl implements SoundService {
  final FlutterSoundRecorder _myRecorder;
  final FlutterSoundPlayer _player;

  SoundServiceImpl(
      {required FlutterSoundRecorder myRecorder,
      required FlutterSoundPlayer myPlayer})
      : _myRecorder = myRecorder,
        _player = myPlayer;

  @override
  Future<void> openAudioSession() async {
    await _myRecorder.openRecorder();
  }

  @override
  Future<void> startRecord({required String pathToSave}) async {
    await _myRecorder.startRecorder(toFile: pathToSave);
  }

  @override
  Future<String?> stopRecord() async {
    String? pathSavedAudio = await _myRecorder.stopRecorder();
    return pathSavedAudio;
  }

  @override
  Future<void> closeAudioSession() async {
    await _myRecorder.closeRecorder();
  }

  @override
  Future<void> playSound(String pathAudio) async {
    await _player.startPlayer(fromURI: pathAudio);
  }

  @override
  Future<void> openAudioSessionPlayer() async{
  await _player.openPlayer();
  }

  @override
  Future<void> closeAudioSessionPlayer()async {
    await _player.closePlayer();
  }
}
