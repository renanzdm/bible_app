

abstract class SoundService{
  Future<void> playSound(String pathAudio);
  Future<void> openAudioSessionPlayer();
  Future<void> closeAudioSessionPlayer();

}