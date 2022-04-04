part of 'home_bloc.dart';

enum HomeStats { init, loading, failure, success }

class HomeState extends Equatable {
  final HomeStats status;
  final BookModel bookSelected;
  final ChapterModel chapterSelected;
  final VerseModel verseSelected;
  final List<VerseModel> versesList;
  final List<VersesMarkedModel> listMarkedModel;
  final int indexItemClicked;
  final VersesMarkedModel verseIfExists;
  final Color pickerColor;
  final Color currentColor;
  final bool scrollableListVerses;
  final bool activeAnimation;
  final bool listMarkedLoaded;

  const HomeState(
      {this.pickerColor = const Color.fromARGB(255, 124, 20, 180),
      this.currentColor = const Color.fromARGB(255, 154, 14, 224),
      this.status = HomeStats.init,
      this.bookSelected = const BookModel(),
      this.chapterSelected = const ChapterModel(),
      this.verseSelected = const VerseModel(),
      this.versesList = const <VerseModel>[],
      this.listMarkedModel = const <VersesMarkedModel>[],
      this.indexItemClicked = -1,
      this.verseIfExists = const VersesMarkedModel(),
      this.scrollableListVerses = false,
        this.activeAnimation=false,
        this.listMarkedLoaded=false
      });

  @override
  List<Object?> get props => [
        status,
        bookSelected,
        chapterSelected,
        verseSelected,
        versesList,
        listMarkedModel,
        indexItemClicked,
        verseIfExists,
        pickerColor,
        currentColor,
        scrollableListVerses,activeAnimation,listMarkedLoaded
      ];

  HomeState copyWith({
    HomeStats? status,
    BookModel? bookSelected,
    ChapterModel? chapterSelected,
    VerseModel? verseSelected,
    List<VerseModel>? versesList,
    List<VersesMarkedModel>? listMarkedModel,
    int? indexItemClicked,
    VersesMarkedModel? verseIfExists,
    Color? pickerColor,
    Color? currentColor,
    bool? scrollableListVerses,
    bool? activeAnimation,
    bool? listMarkedLoaded,
  }) {
    return HomeState(
      status: status ?? this.status,
      bookSelected: bookSelected ?? this.bookSelected,
      chapterSelected: chapterSelected ?? this.chapterSelected,
      verseSelected: verseSelected ?? this.verseSelected,
      versesList: versesList ?? this.versesList,
      listMarkedModel: listMarkedModel ?? this.listMarkedModel,
      indexItemClicked: indexItemClicked ?? this.indexItemClicked,
      verseIfExists: verseIfExists ?? this.verseIfExists,
      pickerColor: pickerColor ?? this.pickerColor,
      currentColor: currentColor ?? this.currentColor,
      scrollableListVerses:scrollableListVerses?? this.scrollableListVerses,
      activeAnimation: activeAnimation??this.activeAnimation,
      listMarkedLoaded: listMarkedLoaded ?? this.listMarkedLoaded
    );
  }
}
