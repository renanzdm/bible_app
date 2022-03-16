import 'package:commons/commons/services/local_database_service.dart';
import 'package:commons/main.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:module_annotations/model/annotation_model.dart';

import '../model/annotation_insert_model.dart';

class AnnotationController extends ChangeNotifier {
  AnnotationController({
    required LocalDatabaseService localDatabaseService,
  }) : _localService = localDatabaseService {
    getPermissions();
  }

  final LocalDatabaseService _localService;
  String pathAudioCurrent = '';
   List<AnnotationModel> listAnnotations = <AnnotationModel>[];

  void setAudioPath(String pathAudio) {
    pathAudioCurrent = pathAudio;
    notifyListeners();
  }

  Future<void> insertAnnotation(
      {AnnotationInsertModel? annotationModel,
      required int verseId,
      String? text}) async {
    annotationModel ??= const AnnotationInsertModel();
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
    var res = await _localService
        .getValuesCustomQuery(sql: sql, args: [id.toString()]);
    listAnnotations = res.map((e) => AnnotationModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<bool> getPermissions() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      return false;
    }
    return true;
  }
}
