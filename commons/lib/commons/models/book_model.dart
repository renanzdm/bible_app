

import 'chapter_model.dart';

class BookModel {
  final int id;
  final List<ChapterModel> chapters;
  final String abbrev;
  final String nameBook;

  BookModel({
    this.chapters = const [],
    this.abbrev = '',
    this.nameBook = '',
    this.id = -1
  });

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      chapters: List<ChapterModel>.from(
          map['chapters']?.map((x) => ChapterModel.fromMap(x)) ?? const []),
      abbrev: map['abbrev'] ?? '',
      nameBook: map['name'] ?? '',
      id: map['id_book']??''
    );
  }

   @override
  String toString() {
    return 'BookModel(id: $id, abbrev: $abbrev, nameBook: $nameBook,chapters: $chapters)';
  }
}
