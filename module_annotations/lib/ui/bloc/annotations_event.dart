part of 'annotations_bloc.dart';

@immutable
abstract class AnnotationsEvent extends Equatable {
  const AnnotationsEvent();
}

@immutable
class GetPermissions extends AnnotationsEvent {
  @override
  List<Object?> get props => [];
}

class GetAnnotations extends AnnotationsEvent {
  final String id;

  const GetAnnotations({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

class SetPathAudio extends AnnotationsEvent {
  final String pathAudio;

  const SetPathAudio({required this.pathAudio});

  @override
  List<Object?> get props => [pathAudio];
}

class SetTextAnnotation extends AnnotationsEvent {
  final String textAnnotation;

  const SetTextAnnotation({required this.textAnnotation});

  @override
  List<Object?> get props => [textAnnotation];
}

class ClearAnnotation extends AnnotationsEvent {
  const ClearAnnotation();

  @override
  List<Object?> get props => [];
}

@immutable
class InsertAnnotations extends AnnotationsEvent {
  final int verseId;

  const InsertAnnotations({
    required this.verseId,
  });

  @override
  List<Object?> get props => [verseId];
}
