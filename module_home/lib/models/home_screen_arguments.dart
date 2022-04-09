
import 'package:commons/commons/models/chapter_model.dart';
import 'package:commons/commons/models/verse_model.dart';
import 'package:commons/commons/models/book_model.dart';

class HomeScreenArguments {
  BookModel bookModel;
  ChapterModel chapterModel;
  VersesModel verseModel;
 
  HomeScreenArguments({
    required this.bookModel,
    required this.chapterModel,
    required this.verseModel,
  });

  factory HomeScreenArguments.fromMap(Map<String, dynamic> map) {
    return HomeScreenArguments(
      bookModel: map['book'],
      chapterModel: map['chapter'],
      verseModel:map['verse'],
    );
  }

  @override
  String toString() => 'HomeScreenArguments(bookModel: $bookModel, chapterModel: $chapterModel, verseModel: $verseModel)';
}
