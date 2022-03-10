import 'package:commons_dependencies/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:module_annotations/services/record_service.dart';

class RecordAudioController extends ChangeNotifier
    implements ReassembleHandler {
  RecordAudioController({
    required RecordService recordService,
  }) : _recordService = recordService{
    openAudioRecordSession();

  }

  final RecordService _recordService;
  bool isRecorder = false;

  Future<void> getStatusRecorder()async{
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
    String pathToSave = 'annotations_audio_$id.aac';
    await _recordService.startRecord(pathToSave: pathToSave);
    getStatusRecorder();
    setDurationUpdateProgress();
  }

  Future<String?> stopRecorder() async {
    String? pathAudioSaved = await _recordService.stopRecord();
    getStatusRecorder();
    return pathAudioSaved;
  }

  Stream<RecordingDisposition>? get onProgress => _recordService.onProgress;

  Future<void> setDurationUpdateProgress()async{
    await _recordService.setDurationUpdateOnProgress();
  }



  @override
  void reassemble() {
    debugPrint('did hot-reload');
  }
}
