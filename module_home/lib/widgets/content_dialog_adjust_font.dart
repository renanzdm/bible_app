

import 'package:commons/main.dart';
import 'package:flutter/material.dart';
import 'package:module_home/widgets/button_adjust_font.dart';
import 'package:commons_dependencies/main.dart';
import '../home_controller.dart';

class ContentDialogAdjustFont extends StatefulWidget {
  const ContentDialogAdjustFont({Key? key}) : super(key: key);

  @override
  _ContentDialogAdjustFontState createState() =>
      _ContentDialogAdjustFontState();
}

class _ContentDialogAdjustFontState extends State<ContentDialogAdjustFont> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeOfWidget.sizeFromWidth(context, factor: 0.7),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
              'Ajuste sua fonte',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 10,
              ),
              DottedLine(width: SizeOfWidget.sizeFromWidth(context),color: Theme.of(context).backgroundColor,),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonAdjustFont(
                    icon: Icons.add,
                    onTap: () {
                      context.read<HomeController>().increaseFontSize();
                    },
                  ),
                  ButtonAdjustFont(
                    icon: Icons.remove,
                    onTap: () {
                      context.read<HomeController>().decreaseFontSize();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}