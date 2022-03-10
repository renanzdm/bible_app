import 'package:commons/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:commons_dependencies/main.dart';


import '../home_controller.dart';
import 'content_bottom_sheet.dart';

class OverlayColorPicker extends StatelessWidget {
  final VoidCallback onTap;

  const OverlayColorPicker({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    GestureDetector(
                      onTap: () {
                        onTap();
                        if(context.read<HomeController>().idVerseClicked!=null) {
                          Navigator.pushNamed(context, NamedRoutes.annotationPage,arguments: context.read<HomeController>().idVerseClicked);
                        }
                      },
                      child: Icon(
                        CupertinoIcons.pencil_ellipsis_rectangle,
                        size: 35,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Icon(
                        CupertinoIcons.clear_thick,
                        size: 35,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                    ),
                  ],
                ),
              ),
              ContentBottomSheet(
                color: context.read<HomeController>().currentColor,
                onTap: (color) {
                  context.read<HomeController>().changeColor(color);
                  onTap();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
