
import 'package:commons_dependencies/main.dart';

abstract class RecordAudioEvent extends Equatable {
  const RecordAudioEvent();
}

class StartRecorder extends RecordAudioEvent{
  @override
  List<Object?> get props => [];
}

class PauseRecorder extends RecordAudioEvent{
  @override
  List<Object?> get props => [];
}

class StopRecorder extends RecordAudioEvent{
  @override
  List<Object?> get props => [];
}

class ResumeRecorder extends RecordAudioEvent{
  @override
  List<Object?> get props => [];
}

class LoadResourcesAudio extends RecordAudioEvent{
  @override
  List<Object?> get props => [];
}

class DisposeResourcesAudio extends RecordAudioEvent{
  @override
  List<Object?> get props => [];
}
