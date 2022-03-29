import 'package:commons_dependencies/main.dart';
import 'package:flutter/cupertino.dart';

enum StatsStatus { initial, loading, success, failure }

@immutable
class RecordAudioState extends Equatable {
  final StatsStatus status;
  final bool isRunning;
  final bool isStopped;
  final bool isPaused;
  final Stopwatch stopWatch;
  final String pathAudioSaved;
  final Stream<RecordingDisposition>? onProgress;

  const RecordAudioState(
      {required this.stopWatch,
      this.isStopped = true,
      this.status = StatsStatus.initial,
      this.isPaused = false,
      this.isRunning = false,
      this.pathAudioSaved = '',
      this.onProgress});

  @override
  List<Object?> get props =>
      [status, isRunning, isStopped, isPaused, stopWatch, pathAudioSaved,onProgress];

  RecordAudioState copyWith({
    StatsStatus? status,
    bool? isRunning,
    bool? isStopped,
    bool? isPaused,
    Stopwatch? stopWatch,
    String? pathAudioSaved,
    Stream<RecordingDisposition>? onProgress,
  }) {
    return RecordAudioState(
      status: status ?? this.status,
      isRunning: isRunning ?? this.isRunning,
      isStopped: isStopped ?? this.isStopped,
      isPaused: isPaused ?? this.isPaused,
      stopWatch: stopWatch ?? this.stopWatch,
      pathAudioSaved: pathAudioSaved ?? this.pathAudioSaved,
      onProgress: onProgress ?? this.onProgress,
    );
  }
}
