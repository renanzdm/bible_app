import 'package:commons/commons/controller/app_controller.dart';
import 'package:commons/commons/models/book_model.dart';
import 'package:commons/commons/models/chapter_model.dart';
import 'package:commons/commons/models/verse_model.dart';
import 'package:commons/commons/models/verses_marked_model.dart';
import 'package:commons/commons/services/local_database_service.dart';
import 'package:commons/main.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';

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

  int? idVerseClicked;

  Color pickerColor = const Color.fromARGB(255, 124, 20, 180);
  Color currentColor = const Color.fromARGB(255, 154, 14, 224);

  void changeColor(Color color) {
    pickerColor = color;
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

  void setVerseSelected({required int index}) => verseSelected = versesList[index];
  void changeVerseMarkedStatus({required int index}) {
    verseSelected = versesList[index];
    bool oldValueIsMarked = !versesList[index].isMarked;
    versesList[index] = versesList[index]
        .copyWith(isMarked: oldValueIsMarked, colorMarked: pickerColor);
    notifyListeners();
  }

  Future<void> changeTheme() async {
    _appStore.config =
        _appStore.config.copyWith(isDark: !_appStore.config.isDark);
    await _appStore.updateConfigTable();
    notifyListeners();
  }

  Future<void> addVerseMarkedOnTable(
      {required VersesMarkedModel verseMarkedModel}) async {
    idVerseClicked = await _localService.insertValues(
        table: VersesMarkedTable.tableName, values: verseMarkedModel.toMap());
  }

  Future<void> deleteVerseMarkedOnTable({required int id}) async {
    await _localService.delete(
        table: VersesMarkedTable.tableName,
        whereSentence: '${VersesMarkedTable.id} = ? ',
        whereArgs: [id.toString()]);
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
    _appStore.listMarkedModel =
        response.map((e) => VersesMarkedModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<int> getIdVerseOnDatabase() async {
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
      debugPrint(int.tryParse(values.first['id'].toString()).toString());
    }
    return 1;
  }

  @override
  void reassemble() {
    debugPrint('did hot-reload HomeController');
  }
}
