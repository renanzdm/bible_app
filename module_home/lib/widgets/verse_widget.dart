import 'package:commons/commons/controller/app_controller.dart';
import 'package:commons/commons/models/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:commons_dependencies/main.dart';

class VersesWidget extends StatelessWidget {
  const VersesWidget({
    Key? key,
    required this.idVerse,
    required this.indexItem,
    required this.verseModel,
  }) : super(key: key);
  final int idVerse;
  final int indexItem;
  final VerseModel verseModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(
      builder: (BuildContext context, AppController value, Widget? child) {
        return Container(
          color: verseModel.isMarked ? verseModel.colorMarked : null,
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontSize: value
                      .config
                      .fontSizeVerse
                      .toDouble(),
                  fontWeight: FontWeight.bold),
              text: idVerse.toString() + ' ',
              children: [
                TextSpan(
                  text: verseModel.verse,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontSize: value
                          .config
                          .fontSizeVerse
                          .toDouble()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
