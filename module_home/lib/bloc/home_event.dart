part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class SetCurrentBible extends HomeEvent {
  const SetCurrentBible({
    required this.bookCurrent,
    required this.chapterCurrent,
    required this.verseCurrent,
  });

  final BookModel bookCurrent;
  final ChapterModel chapterCurrent;
  final VersesModel verseCurrent;

  @override
  List<Object?> get props => [bookCurrent, chapterCurrent, verseCurrent];
}

class GetListVersesMarked extends HomeEvent {
  const GetListVersesMarked();

  @override
  List<Object?> get props => [];
}

class ConfigureVersesMarked extends HomeEvent {
 const ConfigureVersesMarked();

  @override
  List<Object?> get props => [];

}

class MakeConfigurationVerses extends HomeEvent{
  @override
  List<Object?> get props => [];
}

class ActiveAnimateListView extends HomeEvent{
  final  bool animate;

  const ActiveAnimateListView(this.animate);

  @override
  List<Object?> get props => [];
}
class ActiveAnimationController extends HomeEvent{
  final  bool animate;

  const ActiveAnimationController(this.animate);

  @override
  List<Object?> get props => [];
}

class AddVerseOnTable extends HomeEvent{
  const AddVerseOnTable();
  @override
  List<Object?> get props => [];
}

