
import 'package:commons/commons/models/bible_model.dart';
import 'package:commons/commons/models/book_model.dart';
import 'package:commons/commons/models/verse_model.dart';
import 'package:commons/commons/models/chapter_model.dart';
import 'package:mobx/mobx.dart';

part 'summary_store.g.dart';

class SummaryStore = _SummaryStoreBase with _$SummaryStore;

abstract class _SummaryStoreBase with Store {
  BookModel bookSelected = BookModel();
  ChapterModel chapterSelected = ChapterModel();
  VerseModel verseSelected = VerseModel();
  String versionBibleSelected = '';



  void setBookSelected(BookModel value) {
    bookSelected = value;
  }

  void setChapterSelected(ChapterModel value) {
    chapterSelected = value;
  }

  void setVerseSelected(VerseModel value) {
    verseSelected = value;
  }



  void setVersionBibleSelected(String value) {
    versionBibleSelected = value;
  }


  void setDefaultValuesBible({required BibleModel bibleModel}) {
    bookSelected = BookModel(
        abbrev: bibleModel.books.first.abbrev,
        nameBook: bibleModel.books.first.nameBook,
        chapters: bibleModel.books.first.chapters,id: 1);
    chapterSelected =
        ChapterModel(verses: bibleModel.books.first.chapters.first.verses,id: 1);
    verseSelected = VerseModel(
        verse: bibleModel.books.first.chapters.first.verses.first.verse,id: 1);
    versionBibleSelected = bibleModel.version;
  }
}
