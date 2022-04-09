import 'package:flutter/material.dart';

class VersesModel {
  final int id;
  final String verse;
  final bool isMarked;
  final  Color colorMarked;

  const VersesModel(
      {this.id = -1,
      this.verse = '',
      this.isMarked = false,
      this.colorMarked = const Color(0xFFFFFFFF)});

  factory VersesModel.fromMap(Map<String, dynamic> map) {
    return VersesModel(
      verse: map['text'],
      id: map['id_verse'],
      isMarked: map['is_marked'] == 0 ? false : true,
      colorMarked: Color(map['color_marked'] ?? 0xFFFFFF),
    );
  }

  VersesModel copyWith({
    int? id,
    String? verse,
    bool? isMarked,
    Color? colorMarked,
  }) {
    return VersesModel(
      id: id ?? this.id,
      verse: verse ?? this.verse,
      isMarked: isMarked ?? this.isMarked,
      colorMarked: colorMarked ?? this.colorMarked,
    );
  }

  @override
  String toString() {
    return 'VerseModel{id: $id, verse: $verse, isMarked: $isMarked, colorMarked: $colorMarked}';
  }
}
