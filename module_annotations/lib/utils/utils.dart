import 'package:commons/commons/models/bible_model.dart';
import 'package:commons/commons/models/book_model.dart';

class Utils {
 static String getNameBook({required int idBook, required BibleModel bibleModel}) {
    BookModel bookModel =
        bibleModel.books.singleWhere((element) => element.id == idBook);
    return bookModel.nameBook;
  }
}
