import 'package:commons/commons/controller/app_controller.dart';
import 'package:commons/commons/local_database/local_database_instance.dart';
import 'package:commons/commons/models/verses_marked_model.dart';
import 'package:commons/commons/repositories/local_database_repository_impl.dart';
import 'package:commons/commons/services/local_database_service_impl.dart';
import 'package:commons/main.dart';
import 'package:flutter/material.dart';
import 'package:module_home/home_screen_arguments.dart';
import 'package:module_home/widgets/verse_widget.dart';
import 'package:commons_dependencies/main.dart';
import 'home_controller.dart';
import 'widgets/content_dialog_adjust_font.dart';
import 'widgets/overlay_color_picker.dart';

enum OptionValue { adjustFont, darkMode }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeController(
              localDatabaseService: LocalDatabaseServiceImpl(
                localDatabaseRepository: LocalDatabaseRepositoryImpl(
                  database: LocalDatabaseInstance(),
                ),
              ),
              appStore: context.read<AppController>()),
        ),
      ],
      child: const HomePageContent(),
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent>
    with AutomaticKeepAliveClientMixin {
  late AppController _appStore;
  late HomeController _homeStore;
  late OverlayEntry _overlayEntry;
  late List<PopupMenuEntry<OptionValue>> listPopButtons;
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void dispose() {
    removeOverlayScreen();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _appStore = context.read<AppController>();
    _homeStore = context.read<HomeController>();
    createOverlaySelectVerse();
    WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) async {
      _scrollController.jumpTo(index: _homeStore.verseSelected.id - 1);
      await _homeStore.getVersesMarkedOnTable();
      _homeStore.configureVersesMarked(_appStore.listMarkedModel);
    });
  }

  void createOverlaySelectVerse() {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => ChangeNotifierProvider.value(
        value: _homeStore,
        child: OverlayColorPicker(
          onTap: () {
            removeOverlayScreen();
          },
        ),
      ),
    );
  }

  void removeOverlayScreen() {
    if (_overlayEntry.mounted) _overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    HomeScreenArguments args = getRouteArguments(context);
    setDefaultValuesBible(args);
    generatePopUpButtons(context);
    return Scaffold(
      appBar: AppBarWidget(
        actions: [
          ActionsAppBarWidget(
            width: 100,
            text: _homeStore.bookSelected.nameBook,
            onTap: () {
              Navigator.pop(context, 0);
            },
          ),
          ActionsAppBarWidget(
            width: 60,
            text: _homeStore.chapterSelected.id.toString(),
            onTap: () {
              Navigator.pop(context, 1);
            },
          ),
          ActionsAppBarWidget(
            width: 60,
            text: _appStore.config.versionBible,
            fontSize: 12,
            onTap: () =>
                Navigator.pushNamed(context, NamedRoutes.configVersionsPage),
          ),
          PopupMenuButton<OptionValue>(
            onSelected: (OptionValue value) async {
              switch (value) {
                case OptionValue.adjustFont:
                  await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return ChangeNotifierProvider.value(
                          value: _homeStore,
                          child: const Center(
                            child: ContentDialogAdjustFont(),
                          ),
                        );
                      });

                  break;
                case OptionValue.darkMode:
                  _homeStore.changeTheme();
                  break;
              }
            },
            icon: const Icon(Icons.more_vert_outlined),
            itemBuilder: (BuildContext context) {
              return listPopButtons;
            },
          ),
        ],
      ),
      body: Consumer<HomeController>(
        builder: (BuildContext context, HomeController value, Widget? child) {
          return Padding(
            padding: ScaffoldPadding.horizontal,
            child: SizedBox(
              child: ScrollablePositionedList.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _homeStore.versesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      if (!_overlayEntry.mounted) {
                        Overlay.of(context)!.insert(_overlayEntry);
                      }
                      _homeStore.setVerseModelSelected(index: index);
                      await _homeStore.addVerseMarkedOnTable(
                        VersesMarkedModel(
                            bookId: _homeStore.bookSelected.id,
                            chapterId: _homeStore.chapterSelected.id,
                            verseId: _homeStore.verseSelected.id,
                            colorMarked: _homeStore.pickerColor),
                      );
                    },
                    onLongPress: (){
                      if(context.read<HomeController>().idVerseClicked!=null) {
                        Navigator.pushNamed(context, NamedRoutes.annotationPage,arguments: context.read<HomeController>().idVerseClicked);
                      }
                    },
                    child: VersesWidget(
                        verseModel: value.versesList[index],
                        idVerse: value.versesList[index].id,
                        indexItem: index),
                  );
                },
                itemScrollController: _scrollController,
                itemPositionsListener: itemPositionsListener,
              ),
            ),
          );
        },
      ),
    );
  }

  HomeScreenArguments getRouteArguments(BuildContext context) {
    HomeScreenArguments args = HomeScreenArguments.fromMap(
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>);
    return args;
  }

  void setDefaultValuesBible(HomeScreenArguments args) {
    _homeStore.setDefaultValuesBible(
      verseModel: args.verseModel,
      chapterModel: args.chapterModel,
      bookModel: args.bookModel,
    );
  }

  void generatePopUpButtons(BuildContext context) {
    listPopButtons = [
      PopupMenuItem(
        value: OptionValue.adjustFont,
        child: Text(
          "Ajustar Fonte",
          style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
        ),
      ),
      PopupMenuItem(
        value: OptionValue.darkMode,
        child: Text(
          'Mudar Tema',
          style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
        ),
      ),
    ];
  }

  @override
  bool get wantKeepAlive => true;
}
