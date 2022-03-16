import 'package:commons/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:commons_dependencies/main.dart';

import '../home_controller.dart';
import 'content_bottom_sheet.dart';
import 'dialog_alert_delete_marked_verse.dart';

class OverlayColorPicker extends StatelessWidget {
  final VoidCallback onTapRemoveThisOverlay;

  const OverlayColorPicker({Key? key, required this.onTapRemoveThisOverlay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController _homeController = context.read<HomeController>();
    return Builder(builder: (context) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 300,
          width: SizeOfWidget.sizeFromWidth(context),
          child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            color: Colors.black54,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 700),

                        child: context
                                .watch<HomeController>()
                                .verseSelected
                                .isMarked
                            ? GestureDetector(
                                onTap: () {
                                  onTapRemoveThisOverlay();
                                  Navigator.pushNamed(
                                      context, NamedRoutes.annotationPage,
                                      arguments: context
                                          .read<HomeController>()
                                          .verseIfExists.id);
                                },
                                child: Icon(
                                  CupertinoIcons.pencil_ellipsis_rectangle,
                                  size: 35,
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                ),
                              )
                            : const SizedBox.square(dimension: 20,),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: onTapRemoveThisOverlay,
                        child: Icon(
                          CupertinoIcons.arrow_down,
                          size: 35,
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 700),
                        child: context
                                .watch<HomeController>()
                                .verseSelected
                                .isMarked
                            ? GestureDetector(
                                onTap: () async {
                                  onTapRemoveThisOverlay();
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ChangeNotifierProvider.value(
                                        value: _homeController,
                                        child: const UnmarkedVerseDialog(),
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  CupertinoIcons.delete,
                                  size: 35,
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                ),
                              )
                            : const SizedBox.square(dimension: 20),
                      ),
                    ],
                  ),
                ),
                ContentBottomSheet(
                  color: context.read<HomeController>().currentColor,
                  onTap: (color) async {
                    await _homeController.getIdVerseOnDatabase();
                    await _homeController.addVerseMarkedOnTable(color: color);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
