part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class ChangeColor extends HomeEvent {
  final Color color;
  const ChangeColor({
    required this.color,
  });

  @override
  List<Object?> get props => [color];
}

class SetIndexVerseClicked extends HomeEvent {
  final int index;
  const SetIndexVerseClicked({
    this.index = 0,
  });

  @override
  List<Object?> get props => [index];
}

class SetDefaultValuesBible extends HomeEvent {
  final VerseModel verseModel;
  final ChapterModel chapterModel;
  final BookModel bookModel;
  const SetDefaultValuesBible({
    required this.verseModel,
    required this.chapterModel,
    required this.bookModel,
  });

  @override
  List<Object?> get props => [verseModel, chapterModel, bookModel];
}

class ConfigureVersesMarked extends HomeEvent {
  const ConfigureVersesMarked();

  @override
  List<Object?> get props => [];
}

class SetVerseSelected extends HomeEvent {
  final int index;
  const SetVerseSelected({
    this.index = 0,
  });
  @override
  List<Object?> get props => [index];
}

class ChangeVerseMarkedStatus extends HomeEvent {
  final bool valueForMarked;
  const ChangeVerseMarkedStatus({
    this.valueForMarked = false,
  });
  @override
  List<Object?> get props => [valueForMarked];
}

class AddVerseMarkedOnTable extends HomeEvent {
  final Color color;
  const AddVerseMarkedOnTable({
    required this.color,
  });
  @override
  List<Object?> get props => [];
}

class UpdateColorVerseMarked extends HomeEvent {
  final VersesMarkedModel model;
  const UpdateColorVerseMarked({
    required this.model,
  });

  @override
  List<Object?> get props => [model];
}


class DeleteVerseMarkedOnTable extends HomeEvent {
 final VersesMarkedModel verseIfExists;
  const DeleteVerseMarkedOnTable({
    required this.verseIfExists,
  });

  @override
  List<Object?> get props => [verseIfExists];
  
}

class GetVersesMarkedOnTable extends HomeEvent{
const GetVersesMarkedOnTable();

  @override
  List<Object?> get props => [];

}

class GetIdVerseOnDatabase extends HomeEvent{
  @override
  List<Object?> get props => [];
  
}


