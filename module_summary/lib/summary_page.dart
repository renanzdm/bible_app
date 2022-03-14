
import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';
import 'package:module_summary/summary_controller.dart';
import 'pages/books_page.dart';
import 'pages/chapters_page.dart';
import 'pages/verses_page.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage>
    with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>SummaryController()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Indice'),
          bottom: TabBar(
            isScrollable: false,
            indicatorColor: Colors.yellow,
            controller: _tabController,
            tabs: const [
              Tab(
                child: Text(
                 'Livros',
                ),
                icon: Icon(
                  Icons.book_outlined,
                  size: 20,
                ),
              ),
              Tab(
                child: Text(
                  'Capitulos',
                ),
                icon: Icon(
                  Icons.collections_bookmark_outlined,
                  size: 20,
                ),
              ),
              Tab(
                child: Text('Versiculos'),
                icon: Icon(
                  Icons.list_outlined,
                  size: 20,
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            BooksPage(
              tabController: _tabController,
            ),
            ChaptersPage(tabController: _tabController),
            VersesPage(tabController: _tabController,)
          ],
        ),
      ),
    );
  }



}
