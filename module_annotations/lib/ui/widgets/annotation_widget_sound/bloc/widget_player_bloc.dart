import 'package:commons_dependencies/main.dart';
import 'package:meta/meta.dart';

import '../../../../services/sound_service/sound_service.dart';

part 'widget_player_event.dart';
part 'widget_player_state.dart';

class SoundPlayerBloc extends Bloc<SoundPlayerEvent, SoundPlayerState> {
  SoundPlayerBloc({required SoundService soundService})
      : _soundService = soundService,
        super(const SoundPlayerState()) {
    on<InitResourceAudio>(_initResourcesAudio);
    on<DisposeResourcesAudio>(_closeAudioSessionPlayer);
    on<PlaySound>(_playSong);
    on<PauseSong>(_pauseSong);
    on<ResumeSong>(_resumeSong);
    on<SeekPlayer>(_seekToPlayer);
    on<StopSound>(_stopSong);
  }

  final SoundService _soundService;

  Future<void> _initResourcesAudio(
      InitResourceAudio event, Emitter<SoundPlayerState> emit) async {
    emit(state.copyWith(status: PlayerStats.loading));
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    await _soundService.openAudioSessionPlayer();
    await _soundService.setDurationUpdateOnProgress();
    emit(state.copyWith(status: PlayerStats.success));
  }

  Future<void> _closeAudioSessionPlayer(
      DisposeResourcesAudio event, Emitter<SoundPlayerState> emit) async {
    emit(state.copyWith(status: PlayerStats.loading));
    await _soundService.closeAudioSessionPlayer();
    emit(state.copyWith(status: PlayerStats.initial));
  }

  Future<void> _playSong(
      PlaySound event, Emitter<SoundPlayerState> emit) async {
    emit(state.copyWith(status: PlayerStats.loading));
    await _soundService.playSound(event.pathAudio);
    var playerState = await _soundService.getPlayerState();
    emit(state.copyWith(
        status: PlayerStats.success,
        playbackProgress: _soundService.onProgress,
        playerState: playerState));
  }

  Future<void> _pauseSong(
      PauseSong event, Emitter<SoundPlayerState> emit) async {
    emit(state.copyWith(status: PlayerStats.loading));
    await _soundService.pauseSound();
    var playerState = await _soundService.getPlayerState();
    emit(state.copyWith(
        status: PlayerStats.success,
        playbackProgress: _soundService.onProgress,
        playerState: playerState));
  }

  Future<void> _stopSong(
      StopSound event, Emitter<SoundPlayerState> emit) async {
    emit(state.copyWith(
        status: PlayerStats.success,
        playbackProgress: _soundService.onProgress,
        playerState: PlayerState.isStopped));
  }

  Future<void> _resumeSong(
      ResumeSong event, Emitter<SoundPlayerState> emit) async {
    emit(state.copyWith(status: PlayerStats.loading));
    await _soundService.resumeSound();
    var playerState = await _soundService.getPlayerState();
    emit(state.copyWith(
        status: PlayerStats.success,
        playbackProgress: _soundService.onProgress,
        playerState: playerState));
  }

  Future<void> _seekToPlayer(
      SeekPlayer event, Emitter<SoundPlayerState> emit) async {
    emit(state.copyWith(status: PlayerStats.loading));
    await _soundService.seekToPlayer(duration: event.duration);
    emit(state.copyWith(
      status: PlayerStats.success,
      playbackProgress: _soundService.onProgress,
    ));
  }
}
