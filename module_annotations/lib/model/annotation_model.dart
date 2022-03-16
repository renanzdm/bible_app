import 'package:commons/commons/utils/tables_info.dart';

class AnnotationModel {
  final String audioAnnotationPath;

  final String textAnnotation;
  final int fkMarkedVerseID;
  final int bookId;
  final int chapterId;
  final int verseId;

  const AnnotationModel({
    this.audioAnnotationPath = '',
    this.textAnnotation = '',
    required this.fkMarkedVerseID,
    required this.bookId,
    required this.chapterId,
    required this.verseId,
  });

  Map<String, dynamic> toMap() {
    return {
      AnnotationsVersesTable.annotationAudio: audioAnnotationPath,
      AnnotationsVersesTable.annotationText: textAnnotation,
      AnnotationsVersesTable.fkVerseMarkedId: fkMarkedVerseID,
      VersesMarkedTable.bookId: bookId,
      VersesMarkedTable.chapterId: chapterId,
      VersesMarkedTable.verseId: verseId,
    };
  }

  factory AnnotationModel.fromMap(Map<String, dynamic> map) {
    return AnnotationModel(
      audioAnnotationPath: map[AnnotationsVersesTable.annotationAudio] ?? '',
      textAnnotation: map[AnnotationsVersesTable.annotationText] ?? '',
      fkMarkedVerseID: map[AnnotationsVersesTable.fkVerseMarkedId],
      bookId: map[VersesMarkedTable.bookId],
      chapterId: map[VersesMarkedTable.chapterId],
      verseId: map[VersesMarkedTable.verseId],
    );
  }

  AnnotationModel copyWith({
    String? audioAnnotationPath,
    String? textAnnotation,
    int? fkMarkedVerseID,
    int? bookId,
    int? chapterId,
    int? verseId,
  }) {
    return AnnotationModel(
      audioAnnotationPath: audioAnnotationPath ?? this.audioAnnotationPath,
      textAnnotation: textAnnotation ?? this.textAnnotation,
      fkMarkedVerseID: fkMarkedVerseID ?? this.fkMarkedVerseID,
      bookId: bookId ?? this.bookId,
      chapterId: chapterId ?? this.chapterId,
      verseId: verseId ?? this.verseId,
    );
  }

  @override
  String toString() {
    return 'AnnotationModel{audioAnnotationPath: $audioAnnotationPath, textAnnotation: $textAnnotation, fkMarkedVerseID: $fkMarkedVerseID, bookId: $bookId, chapterId: $chapterId, verseId: $verseId}';
  }
}
