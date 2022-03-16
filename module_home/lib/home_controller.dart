import 'package:commons/commons/controller/app_controller.dart';
import 'package:commons/commons/models/book_model.dart';
import 'package:commons/commons/models/chapter_model.dart';
import 'package:commons/commons/models/verse_model.dart';

import 'package:commons/commons/services/local_database_service.dart';
import 'package:commons/main.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';

import 'models/verses_marked_model.dart';

class HomeController extends ChangeNotifier implements ReassembleHandler {
  HomeController(
      {required LocalDatabaseService localDatabaseService,
      required AppController appStore})
      : _localService = localDatabaseService,
        _appStore = appStore;

  final AppController _appStore;
  final LocalDatabaseService _localService;
  BookModel bookSelected = BookModel();
  ChapterModel chapterSelected = ChapterModel();
  VerseModel verseSelected = VerseModel();
  List<VerseModel> versesList = [];
  List<VersesMarkedModel> listMarkedModel = <VersesMarkedModel>[];

  int indexItemClicked = -1;
  VersesMarkedModel verseIfExists = const VersesMarkedModel();

  Color pickerColor = const Color.fromARGB(255, 124, 20, 180);
  Color currentColor = const Color.fromARGB(255, 154, 14, 224);

  Future<void> changeColor({required Color color}) async {
    pickerColor = color;
  }

  void setIndexVerseClicked(int index) {
    indexItemClicked = index;
  }

  void setDefaultValuesBible({
    required VerseModel verseModel,
    required ChapterModel chapterModel,
    required BookModel bookModel,
  }) {
    bookSelected = bookModel;
    chapterSelected = chapterModel;
    verseSelected = verseModel;
    versesList = chapterSelected.verses;
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

  void setVerseSelected({required int index}) {
    verseSelected = versesList[index];
    notifyListeners();
  }

  void changeVerseMarkedStatus({required bool valueForMarked}) {
    versesList[indexItemClicked] = versesList[indexItemClicked]
        .copyWith(colorMarked: pickerColor, isMarked: valueForMarked);
  }

  Future<void> changeTheme() async {
    _appStore.config =
        _appStore.config.copyWith(isDark: !_appStore.config.isDark);
    await _appStore.updateConfigTable();
    notifyListeners();
  }

  Future<void> addVerseMarkedOnTable({required Color color}) async {
    if (verseIfExists.id == -1) {
      VersesMarkedModel verseModelSelected = VersesMarkedModel(
          bookId: bookSelected.id,
          chapterId: chapterSelected.id,
          verseId: verseSelected.id,
          colorMarked: pickerColor);
      changeColor(color: color);
      changeVerseMarkedStatus(valueForMarked: true);
      int idItemInserted = await _localService.insertValues(
          table: VersesMarkedTable.tableName,
          values: verseModelSelected.toMap());
      verseIfExists = verseIfExists.copyWith(id: idItemInserted);
      ///Set for true for leave icons of delete verse and add annotation
      verseSelected = verseSelected.copyWith(isMarked: true);
    } else {
      changeColor(color: color);
      changeVerseMarkedStatus(valueForMarked: true);
      await updateColorVerseMarked(model: verseIfExists);
    }
    notifyListeners();
  }

  Future<void> updateColorVerseMarked(
      {required VersesMarkedModel model}) async {
    model = model.copyWith(colorMarked: pickerColor);
    await _localService.updateValue(
        table: VersesMarkedTable.tableName,
        values: model.toMap(),
        whereSentence: 'id = ?',
        whereArgs: [model.id.toString()]);
  }

  Future<void> deleteVerseMarkedOnTable() async {
    if (verseIfExists.id != -1) {
      await _localService.delete(
          table: VersesMarkedTable.tableName,
          whereSentence: '${VersesMarkedTable.id} = ? ',
          whereArgs: [verseIfExists.id.toString()]);
      changeVerseMarkedStatus(valueForMarked: false);
      verseIfExists = verseIfExists.copyWith(id: -1);
      notifyListeners();
    }
  }

  Future<void> increaseFontSize() async {
    double sizeFont = _appStore.config.fontSizeVerse.toDouble();
    if (_appStore.config.fontSizeVerse < 24) {
      sizeFont++;
    }
    _appStore.config = _appStore.config.copyWith(fontSizeVerse: sizeFont);
    await _appStore.updateConfigTable();
  }

  Future<void> decreaseFontSize() async {
    double sizeFont = _appStore.config.fontSizeVerse.toDouble();
    if (_appStore.config.fontSizeVerse >= 12) {
      sizeFont--;
    }
    _appStore.config = _appStore.config.copyWith(fontSizeVerse: sizeFont);
    await _appStore.updateConfigTable();
  }

  Future<void> getVersesMarkedOnTable() async {
    List response =
        await _localService.getValues(table: VersesMarkedTable.tableName);
    listMarkedModel =
        response.map((e) => VersesMarkedModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> getIdVerseOnDatabase() async {
    List<Map<String, Object?>> values = await _localService.getValues(
        table: VersesMarkedTable.tableName,
        whereSentence:
            '${VersesMarkedTable.bookId} = ?  AND ${VersesMarkedTable.chapterId} = ? AND ${VersesMarkedTable.verseId} = ? ',
        whereArgs: [
          bookSelected.id.toString(),
          chapterSelected.id.toString(),
          verseSelected.id.toString()
        ]);
    if (values.isNotEmpty) {
      VersesMarkedModel versesMarkedModel =
          VersesMarkedModel.fromMap(values.first);
      verseIfExists = versesMarkedModel;
    } else {
      verseIfExists = const VersesMarkedModel(id: -1);
    }
  }

  @override
  void reassemble() {
    debugPrint('did hot-reload HomeController');
  }
}
