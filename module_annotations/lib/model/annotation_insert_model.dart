

import 'package:commons/main.dart';

class AnnotationInsertModel {
  final int id;
  final int fkVersesMarked;
  final String annotationText;
  final String annotationAudio;

  const AnnotationInsertModel({
    this.id = -1,
    this.fkVersesMarked = -1,
    this.annotationText = '',
    this.annotationAudio = '',
  });

  Map<String, dynamic> toMap() {
    return {
      if(id != -1) AnnotationsVersesTable.id: id,
      AnnotationsVersesTable.fkVerseMarkedId: fkVersesMarked,
      AnnotationsVersesTable.annotationText: annotationText,
      AnnotationsVersesTable.annotationAudio: annotationAudio,
    };
  }

  factory AnnotationInsertModel.fromMap(Map<String, dynamic> map) {
    return AnnotationInsertModel(
      id: map[AnnotationsVersesTable.id] as int,
      fkVersesMarked: map[AnnotationsVersesTable.fkVerseMarkedId] as int,
      annotationText: map[AnnotationsVersesTable.annotationText] as String,
      annotationAudio: map[AnnotationsVersesTable.annotationAudio] as String,
    );
  }

  AnnotationInsertModel copyWith({
    int? id,
    int? fkVersesMarked,
    String? annotationText,
    String? annotationAudio,
  }) {
    return AnnotationInsertModel(
      id: id ?? this.id,
      fkVersesMarked: fkVersesMarked ?? this.fkVersesMarked,
      annotationText: annotationText ?? this.annotationText,
      annotationAudio: annotationAudio ?? this.annotationAudio,
    );
  }
}
