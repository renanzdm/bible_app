import 'package:commons_dependencies/main.dart';

import 'record_service.dart';

class RecordServiceImpl implements RecordService {
  const RecordServiceImpl({
    required FlutterSoundRecorder myRecorder,
  }) : _myRecorder = myRecorder;
  final FlutterSoundRecorder _myRecorder;

  @override
  Future<void> openAudioRecordSession() async {
    await _myRecorder.openRecorder();
  }

  @override
  Future<void> startRecord({required String pathToSave}) async {
    await _myRecorder.startRecorder(toFile: pathToSave);
  }

  @override
  Future<String?> stopRecord() async {
    String? pathSavedAudio = await _myRecorder.stopRecorder();
    return pathSavedAudio;
  }

  @override
  Future<void> closeAudioRecordSession() async {

    await _myRecorder.closeRecorder();
  }

  @override
  bool get isRecording => _myRecorder.isRecording;

  @override
  bool get isPaused => _myRecorder.isPaused;

  @override
  bool get isStopped => _myRecorder.isStopped;

  @override
  Stream<RecordingDisposition>? get onProgress => _myRecorder.onProgress;

  @override
  Future<void> setDurationUpdateOnProgress(
      {Duration duration = const Duration(milliseconds: 100)}) async {
    await _myRecorder.setSubscriptionDuration(duration);
  }

  @override
  Future<void> pauseRecord() async {
    await _myRecorder.pauseRecorder();
  }

  @override
  Future<void> resumeRecord() async {
    await _myRecorder.resumeRecorder();
  }


}
