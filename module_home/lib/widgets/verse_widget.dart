import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';

class VersesWidget extends StatefulWidget {
  const VersesWidget({
    Key? key,
    required this.idVerse,
    required this.indexItem,
  }) : super(key: key);
  final int idVerse;
  final int indexItem;

  @override
  State<VersesWidget> createState() => _VersesWidgetState();
}

class _VersesWidgetState extends State<VersesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          color: state.versesList[widget.indexItem].isMarked ? Colors.red : null,
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  // fontSize: value.config.fontSizeVerse.toDouble(),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              text: widget.idVerse.toString() + ' ',
              children: [
                TextSpan(
                  text: state.versesList[widget.indexItem].verse,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      // fontSize: value.config.fontSizeVerse.toDouble()
                      fontSize: 12
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
