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

@immutable
class InsertAnnotations extends AnnotationsEvent {
  final int verseId;
  final String? text;
  final String? audioPath;
  const InsertAnnotations({
    this.audioPath = '',
    this.text = '',
    required this.verseId,
  });
  @override
  List<Object?> get props => [text, verseId, audioPath];
}
