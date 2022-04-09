import 'package:commons/commons/models/bible_model.dart';
import 'package:commons/commons/models/book_model.dart';
import 'package:commons/commons/models/chapter_model.dart';
import 'package:commons/commons/models/verse_model.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';

class SummaryController extends ChangeNotifier implements ReassembleHandler {
  BookModel bookSelected = BookModel();
  ChapterModel chapterSelected = ChapterModel();
  VersesModel verseSelected = VersesModel();
  String versionBibleSelected = '';

  void setBookSelected(BookModel value) {
    bookSelected = value;
    notifyListeners();
  }

  void setChapterSelected(ChapterModel value) {
    chapterSelected = value;
    notifyListeners();
  }

  void setVerseSelected(VersesModel value) {
    verseSelected = value;
    notifyListeners();
  }

  void setVersionBibleSelected(String value) {
    versionBibleSelected = value;
    notifyListeners();
  }

  void setDefaultValuesBible({required BibleModel bibleModel}) {
    bookSelected = BookModel(
        abbrev: bibleModel.books.first.abbrev,
        nameBook: bibleModel.books.first.nameBook,
        chapters: bibleModel.books.first.chapters,
        id: 1);
    chapterSelected = ChapterModel(
        verses: bibleModel.books.first.chapters.first.verses, id: 1);
    verseSelected = VersesModel(
        verse: bibleModel.books.first.chapters.first.verses.first.verse, id: 1);
    versionBibleSelected = bibleModel.version;
  }

  @override
  void reassemble() {
    debugPrint('did hot-reload SummaryController');
  }
}
