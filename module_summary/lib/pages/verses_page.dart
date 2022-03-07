
import 'package:commons/main.dart';
import 'package:flutter/material.dart';

import '../summary_store.dart';


const int tabNumberVerses = 2;

class VersesPage extends StatefulWidget {
  const VersesPage({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  State<VersesPage> createState() => _VersesPageState();
}

class _VersesPageState extends State<VersesPage>
    with AutomaticKeepAliveClientMixin {
 final SummaryStore _summaryController = injector.get<SummaryStore>();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Padding(
        padding: ScaffoldPadding.horizontal,
        child: SizedBox(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
            ),
            itemCount: _summaryController.chapterSelected.verses.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              onTap: () async {
                if (_summaryController.verseSelected.verse.isNotEmpty) {
                  _summaryController.setVerseSelected(
                      _summaryController.chapterSelected.verses[index]);
                  Map<String,dynamic> args = {
                    'book':_summaryController.bookSelected,
                    'chapter':_summaryController.chapterSelected,
                    'verse': _summaryController.verseSelected,
                  };
                  var tabSelected =
                      await Navigator.pushNamed(context, NamedRoutes.homePage,arguments: args);
                  if(tabSelected!=null) {
                    widget.tabController.animateTo(tabSelected as int);
                  }
                }
              },
              contentPadding: const EdgeInsets.all(4.0),
              title: Text(
                _summaryController.chapterSelected.verses[index].id.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
