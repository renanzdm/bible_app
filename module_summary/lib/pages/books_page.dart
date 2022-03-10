import 'package:commons/commons/controller/app_controller.dart';
import 'package:commons/commons/utils/scaffold_padding.dart';
import 'package:flutter/material.dart';
import 'package:commons_dependencies/main.dart';

import '../summary_controller.dart';
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
  late AppController _appStore;
  late SummaryController _summaryController;

@override
  void initState() {
    super.initState();
    _appStore = context.read<AppController>();
    _summaryController = context.read<SummaryController>();
    _summaryController.setDefaultValuesBible(
        bibleModel: _appStore.bibleModel);
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
            itemBuilder: (BuildContext context, int index) => ListTile(
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
