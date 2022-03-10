import 'package:commons_dependencies/main.dart';
import 'package:module_annotations/services/sound_service.dart';

class SoundServiceImpl implements SoundService {
  final FlutterSoundPlayer _player;

  SoundServiceImpl({required FlutterSoundPlayer myPlayer}) : _player = myPlayer;

  @override
  Future<void> playSound(String pathAudio) async {
    await _player.startPlayer(fromURI: pathAudio);
  }

  @override
  Future<void> openAudioSessionPlayer() async {
    await _player.openPlayer();
  }

  @override
  Future<void> closeAudioSessionPlayer() async {
    await _player.closePlayer();
  }
}
