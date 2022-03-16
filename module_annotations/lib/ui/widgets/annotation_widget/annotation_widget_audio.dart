import 'package:flutter/material.dart';

class AnnotationWidgetAudio extends StatelessWidget {
  const AnnotationWidgetAudio(
      {Key? key, required this.chapterNumber, required this.verseNumber,required this.bookName})
      : super(key: key);
  final int chapterNumber;
  final int verseNumber;
  final String bookName;



  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title:  Text(bookName),
        subtitle: Row(
          children: [
            Text(chapterNumber.toString()),
            Text(verseNumber.toString()),
          ],
        ),
      ),
    );
  }
}