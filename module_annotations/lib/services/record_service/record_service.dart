import 'package:commons_dependencies/main.dart';

abstract class RecordService{

  Future<void> setDurationUpdateOnProgress({Duration duration= const Duration(milliseconds: 100)});
  bool get isRecording;
  bool get isPaused;
  bool get isStopped;
  Stream<RecordingDisposition>? get onProgress;
  Future<void> startRecord({required String pathToSave});
  Future<String?> stopRecord();
  Future<void> openAudioRecordSession();
  Future<void> closeAudioRecordSession();
  Future<void> pauseRecord();
  Future<void> resumeRecord();


}