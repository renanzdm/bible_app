import 'dart:math';

import 'package:commons_dependencies/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:module_annotations/services/record_service/record_service.dart';

class RecordAudioController extends ChangeNotifier
    implements ReassembleHandler {
  RecordAudioController({
    required RecordService recordService,
  }) : _recordService = recordService {
    openAudioRecordSession();
  }

  bool isRecorder = false;
  bool  isStopped = false;

  final Stopwatch timer = Stopwatch();

  final RecordService _recordService;

  void getIsStopped(){
    isStopped = _recordService.isStopped;
  }

  void getIsRecorder() {
    isRecorder = _recordService.isRecording;
    notifyListeners();
  }

  Future<void> openAudioRecordSession() async {
    await _recordService.openAudioRecordSession();
  }

  Future<void> closeAudioRecordSession() async {
    return await _recordService.closeAudioRecordSession();
  }

  Future<void> startRecorder(String id) async {
    String pathToSave = 'annotations_audio_${DateTime.now().millisecondsSinceEpoch}.aac';
    await _recordService.startRecord(pathToSave: pathToSave);
    getIsRecorder();
    timer.start();
    setDurationUpdateProgress();
  }

  Future<String?> stopRecorder() async {
    String? pathAudioSaved = await _recordService.stopRecord();
    getIsRecorder();
    timer.reset();
    timer.stop();
    return pathAudioSaved;
  }

  Stream<RecordingDisposition>? get onProgress => _recordService.onProgress;

  Future<void> setDurationUpdateProgress() async {
    await _recordService.setDurationUpdateOnProgress();
  }

  Future<void> pauseRecorder() async {
    await _recordService.pauseRecord();
  getIsRecorder();
    timer.stop();
  }

  Future<void> resumeRecorder() async {
    await _recordService.resumeRecord();
    getIsRecorder();
    timer.start();
  }

  @override
  void reassemble() {
    debugPrint('did hot-reload');
  }
}
