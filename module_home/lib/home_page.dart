import 'package:commons/commons/local_database/local_database_instance.dart';
import 'package:commons/commons/repositories/local_database_repository_impl.dart';
import 'package:commons/commons/services/local_database_service_impl.dart';
import 'package:commons/main.dart';
import 'package:flutter/material.dart';
import 'package:module_home/bloc/home_bloc.dart';
import 'package:module_home/widgets/content_bottom_sheet.dart';
import 'package:module_home/widgets/header_bottom_sheet_colors.dart';
import 'package:module_home/widgets/verse_widget.dart';
import 'models/home_screen_arguments.dart';
import 'widgets/content_dialog_adjust_font.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

enum OptionValue { adjustFont, darkMode }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeScreenArguments? arguments;

  HomeScreenArguments argumentsReceiverOfRoute(BuildContext context) {
    HomeScreenArguments args = HomeScreenArguments.fromMap(
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>);
    return args;
  }

  @override
  Widget build(BuildContext context) {
    arguments ??= argumentsReceiverOfRoute(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            localDatabaseService: LocalDatabaseServiceImpl(
              localDatabaseRepository: LocalDatabaseRepositoryImpl(
                database: LocalDatabaseInstance(),
              ),
            ),
          )
            ..add(SetCurrentBible(
                verseCurrent: arguments!.verseModel,
                chapterCurrent: arguments!.chapterModel,
                bookCurrent: arguments!.bookModel))
            ..add(const GetListVersesMarked()),
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
    with SingleTickerProviderStateMixin {
  late List<PopupMenuEntry<OptionValue>> listPopButtons;
  final scrollDirection = Axis.vertical;
  late AutoScrollController controller;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.decelerate);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    generatePopUpButtons(context);
    return Scaffold(
      appBar: AppBarWidget(
        actions: [
          ActionsAppBarWidget(
            width: 100,
            text: context.read<HomeBloc>().state.bookCurrent.nameBook,
            onTap: () {
              int tabBook = 0;
              Navigator.pop(context, tabBook);
            },
          ),
          ActionsAppBarWidget(
            width: 60,
            text: context.read<HomeBloc>().state.chapterCurrent.id.toString(),
            onTap: () {
              int tabChapters = 1;
              Navigator.pop(context, tabChapters);
            },
          ),
          ActionsAppBarWidget(
            width: 60,
            text: 'NVI-PT',
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
                      builder: (context) {
                        return StatefulBuilder(builder: (context, child) {
                          return const Center(
                            child: ContentDialogAdjustFont(),
                          );
                        });
                      });

                  break;
                case OptionValue.darkMode:
                  // TODO **
                  // _homeController.changeTheme();
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
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.animateList) {
            controller.scrollToIndex(state.verseCurrent.id - 1,
                preferPosition: AutoScrollPosition.begin);
            context.read<HomeBloc>().add(const ActiveAnimateListView(false));
          }
          if (state.activeAnimationController) {
            _animationController
              ..forward()
              ..repeat(reverse: true);
          }else{
            _animationController.stop();
          }
          if (state.makeConfigurationVerses) {
            context.read<HomeBloc>().add(const ConfigureVersesMarked());
            context.read<HomeBloc>().add(const ActiveAnimateListView(true));
          }
        },
        builder: (BuildContext context, HomeState state) {
          if (state.stats == HomeStats.loading) {
            return const Center(child: CircularProgressIndicator.adaptive(),);
          } else if (state.stats == HomeStats.success) {
            return Padding(
              padding: ScaffoldPadding.horizontal,
              child: SizedBox(
                child: ListView.builder(
                  controller: controller,
                  scrollDirection: scrollDirection,
                  physics: const BouncingScrollPhysics(),
                  itemCount: context.read<HomeBloc>().state.versesList.length,
                  itemBuilder: (BuildContext parentContext, int index) {
                    return GestureDetector(
                      onTap: () async {
                        _showBottomSheet(parentContext, index, state);
                        parentContext
                            .read<HomeBloc>()
                            .add(const ActiveAnimationController(true));
                      },
                      child: AutoScrollTag(
                        controller: controller,
                        index: index,
                        key: ValueKey(index),
                        child: VersesWidget(
                            idVerse: context
                                .watch<HomeBloc>()
                                .state
                                .versesList[index]
                                .id,
                            indexItem: index),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Future<void> _showBottomSheet(
      BuildContext parentContext, int index, HomeState state) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SizedBox(
          height: 400,
          width: SizeOfWidget.sizeFromWidth(context, factor: 0.9),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocProvider.value(
                        value: parentContext.read<HomeBloc>(),
                        child: HeaderBottomSheetColors(animation: _animation))
                  ],
                ),
              ),
              Expanded(
                child: ContentBottomSheet(
                    onTap: (color) {
                      parentContext
                          .read<HomeBloc>()
                          .add(const AddVerseOnTable());
                    },
                    color: Colors.red),
              ),
            ],
          ),
        );
      },
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
}
