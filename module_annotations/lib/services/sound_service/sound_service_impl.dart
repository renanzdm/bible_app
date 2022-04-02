import 'package:commons_dependencies/main.dart';
import 'package:module_annotations/services/sound_service/sound_service.dart';

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

  @override
  Future<void> stopSound() async{
   await _player.stopPlayer();
   _player.stopPlayerCompleted(1, true);
  }

  @override
  Future<void> pauseSound() async{
   await _player.pausePlayer();
  }

  @override
  Stream<PlaybackDisposition>? get onProgress {
     return _player.onProgress;
  }

  @override
  Future<void> setDurationUpdateOnProgress({Duration duration = const Duration(milliseconds: 100)}) async {
   _player.setSubscriptionDuration(duration);
  }

  @override
  Future<void> seekToPlayer({required Duration duration})async {
    await _player.seekToPlayer(duration);
  }

  @override
  bool get isPlaying => _player.isPlaying;


  @override
  Future<void> resumeSound()async {
  await _player.resumePlayer();
  }

  @override
  Future<PlayerState> getPlayerState()async {
   return _player.getPlayerState();
  }


}
