
abstract class SoundService{
  Future<void> startRecord({required String pathToSave});
  Future<String?> stopRecord();
  Future<void> openAudioSession();
  Future<void> closeAudioSession();
  Future<void> playSound(String pathAudio);
  Future<void> openAudioSessionPlayer();
  Future<void> closeAudioSessionPlayer();
}