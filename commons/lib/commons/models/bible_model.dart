

import 'book_model.dart';

class BibleModel {
  final List<BookModel> books;
  final String version;
  BibleModel({
    this.books = const <BookModel>[],
    this.version=''
  });
  
  factory BibleModel.fromMap(Map<String, dynamic> map) {
    return BibleModel(
      books: List<BookModel>.from(map['data']?.map((x) => BookModel.fromMap(x)) ?? const []),
      version: map['version']
    );
  }
}
