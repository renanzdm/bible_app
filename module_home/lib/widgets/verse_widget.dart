
import 'package:commons/commons/controller/app_store.dart';
import 'package:commons/commons/models/verse_model.dart';
import 'package:commons/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


class VersesWidget extends StatelessWidget {
  VersesWidget({
    Key? key,
    required this.idVerse,
    required this.indexItem,
    required this.verseModel,
  }) : super(key: key);
  final int idVerse;
  final int indexItem;
  final VerseModel verseModel;

  final AppStore _appStore = injector.get<AppStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Container(
        color: verseModel.isMarked
            ? verseModel.colorMarked
            : null,
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headline6?.copyWith(
                fontSize: _appStore.config.fontSizeVerse.toDouble(),
                fontWeight: FontWeight.bold),
            text: idVerse.toString() + ' ',
            children: [
              TextSpan(
                text: verseModel.verse,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: _appStore.config.fontSizeVerse.toDouble()),
              ),
            ],
          ),
        ),
      );
    });
  }
}


