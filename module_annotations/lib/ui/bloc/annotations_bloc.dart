import 'package:commons/commons/services/local_database_service.dart';
import 'package:commons/main.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/cupertino.dart';
import '../../model/annotation_insert_model.dart';
import '../../model/annotation_model.dart';
part 'annotations_event.dart';
part 'annotations_state.dart';

class AnnotationsBloc extends Bloc<AnnotationsEvent, AnnotationsState> {
  AnnotationsBloc({required LocalDatabaseService localDatabaseService})
      : _localService = localDatabaseService,
        super(const AnnotationsState()) {
    on<GetPermissions>(_getPermissions);
    on<GetAnnotations>(_getAnnotations);
    on<InsertAnnotations>(_insertAnnotation);
  }

  final LocalDatabaseService _localService;

  Future<void> _insertAnnotation(
      InsertAnnotations event, Emitter<AnnotationsState> emit) async {
    emit(state.copyWith(status: AnnotationStats.loading));
    final AnnotationInsertModel annotationModel = AnnotationInsertModel(
        annotationAudio: event.audioPath ?? '',
        annotationText: event.text ?? '',
        fkVersesMarked: event.verseId);
    await _localService.insertValues(
        table: AnnotationsVersesTable.tableName,
        values: annotationModel.toMap());
    emit(state.copyWith(status: AnnotationStats.success));
  }

  Future<void> _getAnnotations(
      GetAnnotations event, Emitter<AnnotationsState> emit) async {
    String sql = '''
    SELECT t1.annotation_audio, t1.annotation_text,t1.fk_verse_marked_id ,
    t2.book_id,
    t2.chapter_id,t2.verse_id
    FROM  annotation_verses t1
    INNER JOIN verses_marked t2
    ON t1.fk_verse_marked_id = t2.id
    WHERE t1.fk_verse_marked_id = ?
    ''';
    emit(state.copyWith(status: AnnotationStats.loading));
    var res =
        await _localService.getValuesCustomQuery(sql: sql, args: [event.id]);
    var listAnnotations = res.map((e) => AnnotationModel.fromMap(e)).toList();
    emit(state.copyWith(
        listAnnotations: listAnnotations, status: AnnotationStats.success));
  }

  Future<void> _getPermissions(
      GetPermissions event, Emitter<AnnotationsState> emit) async {
    emit(state.copyWith(status: AnnotationStats.loading));
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      emit(state.copyWith(status: AnnotationStats.failure));
    }
    emit(state.copyWith(status: AnnotationStats.success));
  }
}
