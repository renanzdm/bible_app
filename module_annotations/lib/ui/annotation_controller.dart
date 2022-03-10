import 'package:commons/commons/models/annotation_verses_marked_model.dart';
import 'package:commons/commons/services/local_database_service.dart';
import 'package:commons/main.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:module_annotations/services/sound_service.dart';

class AnnotationController extends ChangeNotifier {
  AnnotationController({
      required LocalDatabaseService localDatabaseService,
      required SoundService soundService})
      : _localService = localDatabaseService,
        _soundService = soundService{
    sessionAudio();
    getPermissions();
    openAudioSessionPlayer();
  }

  final LocalDatabaseService _localService;
  final SoundService _soundService;
  String? pathAudioCurrent;

  Future<void> insertAnnotation(
      {AnnotationVersesMarkedModel? annotationModel,
      required int verseId,
      String? text}) async {
    annotationModel ??= const AnnotationVersesMarkedModel();
    annotationModel = annotationModel.copyWith(
      annotationAudio: pathAudioCurrent,
      annotationText: text,
      fkVersesMarked: verseId,
    );
    await _localService.insertValues(
        table: AnnotationsVersesTable.tableName,
        values: annotationModel.toMap());
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



  Future<void> closeAudioSessionPlayer() async {
    return await _soundService.closeAudioSessionPlayer();
  }



  Future<void> sessionAudio() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  Future<void> playSound() async {
    await _soundService.playSound('/data/data/com.example.base_app/cache/annotations_audio_5.aac');
  }




}
