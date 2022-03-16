import 'package:commons/main.dart';
import 'package:flutter/cupertino.dart';



class VersesMarkedModel {
  final int id;
  final int bookId;
  final int chapterId;
  final int verseId;
  final Color colorMarked;

  const VersesMarkedModel(
      {this.id = -1,
      this.bookId = -1,
      this.chapterId = -1,
      this.verseId = -1,
      this.colorMarked = const Color(0x00ffffff)});

  Map<String, dynamic> toMap() {
    return {
      if (id != -1) VersesMarkedTable.id: id,
      VersesMarkedTable.bookId: bookId,
      VersesMarkedTable.chapterId: chapterId,
      VersesMarkedTable.verseId: verseId,
      VersesMarkedTable.colorMarked: colorMarked.value
    };
  }

  factory VersesMarkedModel.fromMap(Map<String, dynamic> map) {
    return VersesMarkedModel(
      id: map[VersesMarkedTable.id] as int,
      bookId: map[VersesMarkedTable.bookId] as int,
      chapterId: map[VersesMarkedTable.chapterId] as int,
      verseId: map[VersesMarkedTable.verseId] as int,
      colorMarked: Color(
        map[VersesMarkedTable.colorMarked],
      ),
    );
  }

  VersesMarkedModel copyWith({
    int? id,
    int? bookId,
    int? chapterId,
    int? verseId,
    Color? colorMarked,
  }) {
    return VersesMarkedModel(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapterId: chapterId ?? this.chapterId,
      verseId: verseId ?? this.verseId,
      colorMarked: colorMarked ?? this.colorMarked,
    );
  }

  @override
  String toString() {
    return 'VersesMarkedModel{id: $id, bookId: $bookId, chapterId: $chapterId, verseId: $verseId, colorMarked: $colorMarked}';
  }
}
