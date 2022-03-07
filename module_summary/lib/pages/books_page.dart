
import 'package:commons/commons/controller/app_store.dart';
import 'package:commons/commons/injectors.dart';
import 'package:commons/commons/utils/scaffold_padding.dart';
import 'package:flutter/material.dart';

import '../summary_store.dart';
import 'chapters_page.dart';

const int tabNumberBook = 0;

class BooksPage extends StatefulWidget {
  final TabController tabController;

  const BooksPage({Key? key, required this.tabController}) : super(key: key);

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage>
    with AutomaticKeepAliveClientMixin {
  final AppStore _appStore = injector.get<AppStore>();
  final SummaryStore _summaryController = injector.get<SummaryStore>();



  @override
  void initState() {
    _summaryController.setDefaultValuesBible(
        bibleModel: _appStore.bibleModel);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: ScaffoldPadding.horizontal,
        child: SizedBox(
          child: ListView.builder(
            itemCount: _appStore.bibleModel.books.length,
            itemBuilder: (BuildContext context, int index) =>
                ListTile(
                  contentPadding: const EdgeInsets.all(4.0),
                  onTap: () {
                    _summaryController
                        .setBookSelected(_appStore.bibleModel.books[index]);
                    if (_summaryController.bookSelected.chapters.isNotEmpty) {
                      widget.tabController.animateTo(tabNumberChapters);
                    }
                  },
                  title: Text(
                    _appStore.bibleModel.books[index].nameBook,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6,
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
