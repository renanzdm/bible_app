part of 'annotations_bloc.dart';

enum AnnotationStats { initial, loading, failure, success }

@immutable
class AnnotationsState extends Equatable {
  final AnnotationStats status;
  final List<AnnotationModel> listAnnotations;
  final String pathAudio;

  const AnnotationsState({
    this.status = AnnotationStats.initial,
    this.listAnnotations = const [],
    this.pathAudio = ''
  });

  @override
  List<Object?> get props => [status,listAnnotations];
  AnnotationsState copyWith({
    AnnotationStats? status,
    List<AnnotationModel>? listAnnotations,
  }) {
    return AnnotationsState(
      status: status ?? this.status,
      listAnnotations: listAnnotations ?? this.listAnnotations,
    );
  }
  }
