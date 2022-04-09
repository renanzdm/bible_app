import 'verse_model.dart';

class ChapterModel {
  final int id;
  final List<VersesModel> verses;
  final bool isRead;
  const ChapterModel({this.verses = const [], this.isRead = false, this.id = -1});

  factory ChapterModel.fromMap(Map<String, dynamic> map) {
    return ChapterModel(
        verses: map['chapter_verses']
            .map<VersesModel>((e) => VersesModel.fromMap(e))
            .toList(),
        isRead: map['is_read'] == 0 ? false : true,
        id: map['id_chapter'] ?? '');
  }

  ChapterModel copyWith({
    List<VersesModel>? verses,
    bool? isRead,
  }) {
    return ChapterModel(
      verses: verses ?? this.verses,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  String toString() =>
      'ChapterModel(id: $id, verses: $verses, isRead: $isRead)';
}
