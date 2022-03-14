
import 'package:commons/main.dart';
import 'package:flutter/material.dart';
import 'package:commons_dependencies/main.dart';
import '../summary_controller.dart';
import 'verses_page.dart';

const int tabNumberChapters = 1;

class ChaptersPage extends StatefulWidget {
  final TabController tabController;

  const ChaptersPage({Key? key, required this.tabController}) : super(key: key);

  @override
  State<ChaptersPage> createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage>
    with AutomaticKeepAliveClientMixin {
  late SummaryController _summaryController;


  @override
  void initState() {
    super.initState();
    _summaryController = context.read<SummaryController>();

  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: ScaffoldPadding.horizontal,
        child: SizedBox(
          child: Consumer<SummaryController>(
            builder: (context,value,child) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemCount: value.bookSelected.chapters.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  onTap: () {
                    if (_summaryController.chapterSelected.verses.isNotEmpty) {
                      _summaryController.setChapterSelected(
                          _summaryController.bookSelected.chapters[index]);

                      widget.tabController.animateTo(tabNumberVerses);
                    }
                  },
                  contentPadding: const EdgeInsets.all(4.0),
                  title: Text(
                    value.bookSelected.chapters[index].id.toString(),
                    textAlign: TextAlign.center,
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
