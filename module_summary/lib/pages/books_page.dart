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
  late SummaryController _summaryController;

@override
  void initState() {
    super.initState();
    _summaryController = context.read<SummaryController>();
    _summaryController.setDefaultValuesBible(
        bibleModel: context.read<AppController>().bibleModel);
  }

  @override
  Widget build(BuildContext context) {

    super.build(context);
    return Scaffold(
      body: Padding(
        padding: ScaffoldPadding.horizontal,
        child: SizedBox(
          child: Consumer<AppController>(
            builder: (context,AppController value, child) {
              return ListView.builder(
                itemCount: value.bibleModel.books.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  contentPadding: const EdgeInsets.all(4.0),
                  onTap: () {
                    _summaryController
                        .setBookSelected(context.read<AppController>().bibleModel.books[index]);
                    if (_summaryController.bookSelected.chapters.isNotEmpty) {
                      widget.tabController.animateTo(tabNumberChapters);
                    }
                  },
                  title: Text(
                    value.bibleModel.books[index].nameBook,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
