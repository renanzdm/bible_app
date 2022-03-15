import 'dart:developer';

import 'package:commons/commons/models/annotation_verses_marked_model.dart';
import 'package:commons/commons/services/local_database_service.dart';
import 'package:commons/main.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/cupertino.dart';

class AnnotationController extends ChangeNotifier {
  AnnotationController({
    required LocalDatabaseService localDatabaseService,
  }) : _localService = localDatabaseService {
    getPermissions();
  }

  final LocalDatabaseService _localService;
  String pathAudioCurrent = '';

  void setAudioPath(String pathAudio) {
    pathAudioCurrent = pathAudio;
    notifyListeners();
  }

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

  Future<void> getAnnotations({required String id}) async {
    String sql = '''
    SELECT t1.annotation_audio, t1.annotation_text,t1.fk_verse_marked_id ,
    t2.book_id,
    t2.chapter_id,t2.verse_id
    FROM  annotation_verses t1
    INNER JOIN verses_marked t2
    ON t1.fk_verse_marked_id = t2.id
    WHERE t1.fk_verse_marked_id = ?
    ''';
    var res = await _localService.getValuesCustomQuery(sql: sql,args: ['32']);
    log(res.toString());
  }

  Future<bool> getPermissions() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      return false;
    }
    return true;
  }
}
