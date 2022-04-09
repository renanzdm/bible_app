part of 'home_bloc.dart';

enum HomeStats { init, loading, failure, success }

class HomeState extends Equatable {
  final BookModel bookCurrent;
  final ChapterModel chapterCurrent;
  final VersesModel verseCurrent;
  final HomeStats stats;
  final List<VersesModel> versesList;
  final List<VersesMarkedModel> versesMarked;
  final bool makeConfigurationVerses;
  final bool animateList;
  final bool activeAnimationController;

  const HomeState(
      {this.bookCurrent = const BookModel(),
      this.chapterCurrent = const ChapterModel(),
      this.verseCurrent = const VersesModel(),
      this.stats = HomeStats.init,
      this.versesList = const [],
      this.versesMarked = const [],
      this.makeConfigurationVerses = false,
      this.activeAnimationController = false,
      this.animateList = false});

  @override
  List<Object?> get props => [
        bookCurrent,
        chapterCurrent,
        verseCurrent,
        stats,
        versesList,
        versesMarked,
        makeConfigurationVerses,
        animateList,
       activeAnimationController
      ];

  HomeState copyWith({
    BookModel? bookCurrent,
    ChapterModel? chapterCurrent,
    VersesModel? verseCurrent,
    HomeStats? stats,
    List<VersesModel>? versesList,
    List<VersesMarkedModel>? versesMarked,
    bool? makeConfigurationVerses,
    bool? animateList,
    bool? activeAnimationController,
  }) {
    return HomeState(
      bookCurrent: bookCurrent ?? this.bookCurrent,
      chapterCurrent: chapterCurrent ?? this.chapterCurrent,
      verseCurrent: verseCurrent ?? this.verseCurrent,
      stats: stats ?? this.stats,
      versesList: versesList ?? this.versesList,
      versesMarked: versesMarked ?? this.versesMarked,
      makeConfigurationVerses:
          makeConfigurationVerses ?? this.makeConfigurationVerses,
      animateList: animateList ?? this.animateList,
      activeAnimationController:
          activeAnimationController ?? this.activeAnimationController,
    );
  }
}
