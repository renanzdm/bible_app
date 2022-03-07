import 'package:audio_session/audio_session.dart';
import 'package:commons/commons/models/annotation_verses_marked_model.dart';
import 'package:commons/commons/services/local_database_service.dart';

import 'package:commons/main.dart';

import 'package:mobx/mobx.dart';
import 'package:module_annotations/services/sound_service.dart';
import 'package:permission_handler/permission_handler.dart';


part 'annotation_store.g.dart';

class AnnotationStore = _AnnotationStore with _$AnnotationStore;

abstract class _AnnotationStore with Store {
  _AnnotationStore(
      {required LocalDatabaseService localDatabaseService,
      required SoundService soundService})
      : _localService = localDatabaseService,
        _soundService = soundService;

  final LocalDatabaseService _localService;
  final SoundService _soundService;

  Future<void> insertAnnotation(
      {AnnotationVersesMarkedModel? annotationModel,
      required int verseId,String? audioPath,
      String? text}) async {
    annotationModel ??= const AnnotationVersesMarkedModel();
    annotationModel = annotationModel.copyWith(
      annotationAudio: audioPath,
      annotationText: text,
      fkVersesMarked: verseId,
    );
    await _localService.insertValues(
        table: AnnotationsVersesTable.tableName,
        values: annotationModel.toMap());
  }

  Future<void> openAudioSession() async {
    await _soundService.openAudioSession();
  }
  Future<void> openAudioSessionPlayer() async {
    await _soundService.openAudioSessionPlayer();
  }

  Future<bool> getPermissions() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      return false;
    }
    return true;
  }

  Future<void> closeAudioSession() async {
    return await _soundService.closeAudioSession();
  }
  Future<void> closeAudioSessionPlayer() async {
    return await _soundService.closeAudioSessionPlayer();
  }

  Future<void> startRecorder(String id) async {
    String pathToSave = 'annotations_audio_$id.aac';
    await _soundService.startRecord(pathToSave: pathToSave);
  }

  Future<String?> stopRecorder() async {
   String? pathAudioSaved =  await _soundService.stopRecord();
   return pathAudioSaved;
  }

  Future<void> sessionAudio() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  Future<void> playSound()async{
    await  _soundService.playSound('');
  }




}
