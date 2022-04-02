part of 'widget_player_bloc.dart';

enum PlayerStats{initial, loading, failure, success}

@immutable
class SoundPlayerState extends Equatable {
  final PlayerState playerState;
  final PlayerStats status;
  final Stream<PlaybackDisposition>? playbackProgress;
  const SoundPlayerState({
    this.status = PlayerStats.initial,
    this.playerState = PlayerState.isStopped,
    this.playbackProgress
  });



  @override
  List<Object?> get props => [playerState,playbackProgress,status];

  SoundPlayerState copyWith({
    PlayerState? playerState,
    PlayerStats? status,
    Stream<PlaybackDisposition>? playbackProgress,
  }) {
    return SoundPlayerState(
      playerState: playerState ?? this.playerState,
      status: status ?? this.status,
      playbackProgress: playbackProgress ?? this.playbackProgress,
    );
  }
}
