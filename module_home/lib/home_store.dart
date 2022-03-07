
import 'package:commons/commons/controller/app_store.dart';
import 'package:commons/commons/models/book_model.dart';
import 'package:commons/commons/models/chapter_model.dart';
import 'package:commons/commons/models/verse_model.dart';
import 'package:commons/commons/models/verses_marked_model.dart';
import 'package:commons/commons/services/local_database_service.dart';
import 'package:commons/main.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';



part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore({required LocalDatabaseService localDatabaseService,required AppStore appStore})
      : _localService = localDatabaseService,_appStore = appStore;

  final AppStore _appStore;
  final LocalDatabaseService _localService;
  BookModel bookSelected = BookModel();
  ChapterModel chapterSelected = ChapterModel();
  VerseModel verseSelected = VerseModel();
  @observable
  ObservableList<VerseModel> versesList = ObservableList();
  int? idVerseClicked;

  @observable
  Color pickerColor = const Color.fromARGB(255, 124, 20, 180);
  Color currentColor = const Color.fromARGB(255, 154, 14, 224);

  @action
  void changeColor(Color color) {
    pickerColor = color;
  }

  @action
  void setDefaultValuesBible({
    required VerseModel verseModel,
    required ChapterModel chapterModel,
    required BookModel bookModel,
  }) {
    bookSelected = bookModel;
    chapterSelected = chapterModel;
    verseSelected = verseModel;
    versesList = chapterSelected.verses.asObservable();
  }

  void configureVersesMarked(List<VersesMarkedModel> versesMarked) {
    for (VersesMarkedModel marked in versesMarked) {
      if (marked.bookId == bookSelected.id &&
          marked.chapterId == chapterSelected.id) {
        for (VerseModel verses in versesList) {
          if (marked.verseId == verses.id) {
            verses.isMarked = true;
            verses.colorMarked = marked.colorMarked;
          }
        }
      }
    }
  }

  @action
  setVerseModelSelected({required int index}) {
    verseSelected = versesList[index];
    bool oldValueIsMarked = !versesList[index].isMarked;
    versesList[index] = versesList[index]
        .copyWith(isMarked: oldValueIsMarked, colorMarked: pickerColor);
  }

  @action
  Future<void> changeTheme() async {
    _appStore.config =
        _appStore.config.copyWith(isDark: !_appStore.config.isDark);
    await _appStore.updateConfigTable();
  }



  @action
  Future<void> addVerseMarkedOnTable(
      VersesMarkedModel versesMarkedModel) async {
    int id = await alreadyVerseThisBase(versesMarkedModel);
    if (id == -1) {
      idVerseClicked = await _localService.insertValues(
          table: VersesMarkedTable.tableName,
          values: versesMarkedModel.toMap());
    } else {
      idVerseClicked = null;
      await _localService.delete(
          table: VersesMarkedTable.tableName,
          whereSentence: '${VersesMarkedTable.id} = ? ',
          whereArgs: [id.toString()]);
    }
  }

  Future<int> alreadyVerseThisBase(VersesMarkedModel versesMarkedModel) async {
    await getVersesMarkedOnTable();
    VersesMarkedModel hasThisElementOnList = _appStore.listMarkedModel
        .singleWhere(
            (element) =>
                element.bookId == versesMarkedModel.bookId &&
                element.chapterId == versesMarkedModel.chapterId &&
                element.verseId == versesMarkedModel.verseId,
            orElse: () => const VersesMarkedModel(id: -1));
    return hasThisElementOnList.id;
  }

  @action
  Future<void> increaseFontSize() async {
    double sizeFont = _appStore.config.fontSizeVerse.toDouble();
    if (_appStore.config.fontSizeVerse < 24) {
      sizeFont++;
    }
    _appStore.config = _appStore.config.copyWith(fontSizeVerse: sizeFont);
    await _appStore.updateConfigTable();
  }

  @action
  Future<void> decreaseFontSize() async {
    double sizeFont = _appStore.config.fontSizeVerse.toDouble();
    if (_appStore.config.fontSizeVerse >= 12) {
      sizeFont--;
    }
    _appStore.config = _appStore.config.copyWith(fontSizeVerse: sizeFont);
    await _appStore.updateConfigTable();

  }

  @action
  Future<void> getVersesMarkedOnTable() async {
    List response =
        await _localService.getValues(table: VersesMarkedTable.tableName);
    _appStore.listMarkedModel = response
        .map((e) => VersesMarkedModel.fromMap(e))
        .toList()
        .asObservable();
  }
}
