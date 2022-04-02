part of 'widget_player_bloc.dart';

@immutable
abstract class SoundPlayerEvent extends Equatable {}

class InitResourceAudio extends SoundPlayerEvent {
  @override
  List<Object?> get props => [];
}

class DisposeResourcesAudio extends SoundPlayerEvent {
  @override
  List<Object?> get props => [];
}

class PlaySound extends SoundPlayerEvent {
  final String pathAudio;
  PlaySound({
   required this.pathAudio ,
  });
  @override
  List<Object?> get props => [pathAudio];
}

class SeekPlayer extends SoundPlayerEvent {
  final Duration duration;
  SeekPlayer({
    required this.duration,
  });
  @override
  List<Object?> get props => [];
}

class PauseSong extends SoundPlayerEvent {
  @override
  List<Object?> get props => [];
}

class ResumeSong extends SoundPlayerEvent {
  @override
  List<Object?> get props => [];
}

class StopSound extends SoundPlayerEvent {
  @override
  List<Object?> get props => [];
}

