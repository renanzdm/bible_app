import 'dart:async';
import 'package:commons_dependencies/main.dart';
import 'package:module_annotations/services/record_service/record_service.dart';
import 'package:module_annotations/ui/widgets/record_audio_widget/bloc/record_audio_event.dart';
import 'package:module_annotations/ui/widgets/record_audio_widget/bloc/record_audio_state.dart';

class RecordAudioBloc extends Bloc<RecordAudioEvent, RecordAudioState> {
  RecordAudioBloc({required RecordService recordService})
      : _recordService = recordService,
        super(RecordAudioState(stopWatch: Stopwatch())) {
    on<StartRecorder>(_startRecorder);
    on<LoadResourcesAudio>(_loadResourcesAudio);
    on<StopRecorder>(_stopRecorder);
    on<DisposeResourcesAudio>(_disposeResourcesAudio);
    on<PauseRecorder>(_pauseRecorder);
    on<ResumeRecorder>(_resumeRecorder);
    on<ClearPathAudioAfterSaved>(_clearAudioPathAfterSaved);
  }

  final RecordService _recordService;

  Future<void> _startRecorder(
    StartRecorder event,
    Emitter<RecordAudioState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.loading));
    String pathToSave =
        'annotations_audio_${DateTime.now().millisecondsSinceEpoch}.aac';
    await _recordService.startRecord(pathToSave: pathToSave);
    await _recordService.setDurationUpdateOnProgress();
    state.stopWatch.start();
    emit(
      state.copyWith(
          isRunning: true,
          isStopped: false,
          onProgress: _recordService.onProgress),
    );
  }

  Future<void> _stopRecorder(
    StopRecorder event,
    Emitter<RecordAudioState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.loading));
    state.stopWatch.stop();
    state.stopWatch.reset();
    String? pathAudio = await _recordService.stopRecord();
    emit(state.copyWith(
      isStopped: true,
      isRunning: false,
      isPaused: false,
      pathAudioSaved: pathAudio,
    ));
  }

  Future<void> _pauseRecorder(
    PauseRecorder event,
    Emitter<RecordAudioState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.loading));
    state.stopWatch.stop();
    await _recordService.pauseRecord();
    emit(state.copyWith(isStopped: false, isRunning: false, isPaused: true));
  }

  Future<void> _resumeRecorder(
    ResumeRecorder event,
    Emitter<RecordAudioState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.loading));
    await _recordService.resumeRecord();
    state.stopWatch.start();
    emit(state.copyWith(isStopped: false, isRunning: true, isPaused: false));
  }

  Future<void> _loadResourcesAudio(
    LoadResourcesAudio event,
    Emitter<RecordAudioState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.loading));
    await _recordService.openAudioRecordSession();
    emit(state.copyWith(status: StatsStatus.success));
  }
   Future<void> _clearAudioPathAfterSaved(
    ClearPathAudioAfterSaved event,
    Emitter<RecordAudioState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.success,pathAudioSaved: '',));
  }

  Future<void> _disposeResourcesAudio(
    DisposeResourcesAudio event,
    Emitter<RecordAudioState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.loading));
    await _recordService.closeAudioRecordSession();
    emit(state.copyWith(status: StatsStatus.initial));
  }
}
