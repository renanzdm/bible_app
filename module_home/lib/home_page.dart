import 'package:commons/commons/controller/app_store.dart';
import 'package:commons/commons/models/verses_marked_model.dart';
import 'package:commons/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:module_home/home_screen_arguments.dart';
import 'package:module_home/widgets/verse_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'home_store.dart';
import 'widgets/content_dialog_adjust_font.dart';
import 'widgets/overlay_color_picker.dart';

enum OptionValue { adjustFont, darkMode }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final AppStore _appStore = injector.get<AppStore>();
  final HomeStore _homeStore = injector.get<HomeStore>();
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
    createOverlaySelectVerse();
    WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) async {
      _scrollController.jumpTo(index: _homeStore.verseSelected.id - 1);
      await _homeStore.getVersesMarkedOnTable();
      _homeStore.configureVersesMarked(_appStore.listMarkedModel);
    });
  }

  void createOverlaySelectVerse() {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => OverlayColorPicker(
        onTap: () {
          removeOverlayScreen();
        },
      ),
    );
  }

  void removeOverlayScreen() {
    if (_overlayEntry.mounted) _overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    HomeScreenArguments args = HomeScreenArguments.fromMap(
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>);
    _homeStore.setDefaultValuesBible(
      verseModel: args.verseModel,
      chapterModel: args.chapterModel,
      bookModel: args.bookModel,
    );
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
          'Mudar fonte',
          style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
        ),
      ),
    ];

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
                      builder: (_) {
                        return const Center(
                          child: ContentDialogAdjustFont(),
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
      body: Padding(
        padding: ScaffoldPadding.horizontal,
        child: Observer(
          builder: (context) {
            return SizedBox(
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
                    child: VersesWidget(
                        verseModel: _homeStore.versesList[index],
                        idVerse: _homeStore.versesList[index].id,
                        indexItem: index),
                  );
                },
                itemScrollController: _scrollController,
                itemPositionsListener: itemPositionsListener,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
