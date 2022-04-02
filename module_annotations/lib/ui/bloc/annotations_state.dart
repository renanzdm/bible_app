part of 'annotations_bloc.dart';

enum AnnotationStats { initial, loading, failure, success }

@immutable
class AnnotationsState extends Equatable {
  final AnnotationStats status;
  final List<AnnotationModel> listAnnotations;
  final String pathAudio;
  final String text;

  const AnnotationsState({
    this.status = AnnotationStats.initial,
    this.listAnnotations = const [],
    this.pathAudio = '',
    this.text = ''
  });

  @override
  List<Object?> get props => [status,listAnnotations,text,pathAudio];


  AnnotationsState copyWith({
    AnnotationStats? status,
    List<AnnotationModel>? listAnnotations,
    String? pathAudio,
    String? text,
  }) {
    return AnnotationsState(
      status: status ?? this.status,
      listAnnotations: listAnnotations ?? this.listAnnotations,
      pathAudio: pathAudio ?? this.pathAudio,
      text: text ?? this.text,
    );
  }
}
