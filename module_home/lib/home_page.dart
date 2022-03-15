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
  late HomeController _homeController;
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
    _homeController = context.read<HomeController>();
    createOverlaySelectVerse();
    WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) async {
      _scrollController.jumpTo(index: _homeController.verseSelected.id - 1);
      await _homeController.getVersesMarkedOnTable();
      _homeController.configureVersesMarked(_appStore.listMarkedModel);
    });
  }

  void createOverlaySelectVerse() {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => ChangeNotifierProvider.value(
        value: _homeController,
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
            text: _homeController.bookSelected.nameBook,
            onTap: () {
              Navigator.pop(context, 0);
            },
          ),
          ActionsAppBarWidget(
            width: 60,
            text: _homeController.chapterSelected.id.toString(),
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
                          value: _homeController,
                          child: const Center(
                            child: ContentDialogAdjustFont(),
                          ),
                        );
                      });

                  break;
                case OptionValue.darkMode:
                  _homeController.changeTheme();
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
                itemCount: _homeController.versesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      _homeController.setVerseSelected(index: index);
                      VersesMarkedModel verseModelSelected = VersesMarkedModel(
                          bookId: _homeController.bookSelected.id,
                          chapterId: _homeController.chapterSelected.id,
                          verseId: _homeController.verseSelected.id,
                          colorMarked: _homeController.pickerColor);
                      int id = await _homeController
                          .alreadyVerseThisBase(verseModelSelected);
                      print(id);
                      if (id == -1) {
                        if (!_overlayEntry.mounted) {
                          Overlay.of(context)!.insert(_overlayEntry);
                        }
                        await _homeController.addVerseMarkedOnTable(
                            verseMarkedModel: verseModelSelected);
                        _homeController.changeVerseMarkedStatus(index: index);
                      } else {
                        removeOverlayScreen();
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return ChangeNotifierProvider.value(
                              value: _homeController,
                              child: UnmarkedVerseDialog(
                                id: id,
                                indexItem: index,
                              ),
                            );
                          },
                        );
                      }
                    },
                    onLongPress: _homeController.verseSelected.isMarked
                        ? () async {
                            int idMarkedVerse = await context
                                .read<HomeController>()
                                .getIdVerseOnDatabase();
                            // if(idMarkedVerse!=-1) {
                            //   Navigator.pushNamed(context, NamedRoutes.annotationPage,arguments: idMarkedVerse);
                            // }
                          }
                        : null,
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
    _homeController.setDefaultValuesBible(
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

class UnmarkedVerseDialog extends StatelessWidget {
  const UnmarkedVerseDialog({
    Key? key,
    required this.id,
    required this.indexItem,
  }) : super(key: key);

  final int id;
  final int indexItem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PhysicalModel(
        color: Colors.white,
        elevation: 10,
        borderRadius: BorderRadius.circular(12),
        shadowColor: Colors.black,
        child: Container(
          alignment: Alignment.center,
          width: SizeOfWidget.sizeFromWidth(context, factor: 0.7),
          height: SizeOfWidget.sizeFromWidth(context, factor: 0.5),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text('Deseja Desmarcar esse versiculo ?',style: Theme.of(context).textTheme.headline6,),
              const SizedBox(height: 3.0,),
              DottedLine(width: SizeOfWidget.sizeFromWidth(context),color: Theme.of(context).backgroundColor,),
              const SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await context
                            .read<HomeController>()
                            .deleteVerseMarkedOnTable(id: id);
                        context
                            .read<HomeController>()
                            .changeVerseMarkedStatus(index: indexItem);
                        Navigator.pop(context);
                      },
                      child: const Text('Confirmar')),
                  const SizedBox(width: 30.0,),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
