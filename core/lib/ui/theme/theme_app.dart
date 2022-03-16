
import 'package:commons/commons/controller/app_controller.dart';
import 'package:commons/main.dart';
import 'package:flutter/material.dart';
import 'package:commons_dependencies/main.dart';


class ThemeApp {
  static ThemeData theme(BuildContext context) {
    AppController _appStore = context.watch<AppController>();
    return ThemeData(
      colorScheme: () {
        if (_appStore.config.isDark) {
          return colorSchemaDark;
        } else {
          return colorSchemaLight;
        }
      }(),
    );
  }
}

const ColorScheme colorSchemaDark = ColorScheme.dark();
const ColorScheme colorSchemaLight = ColorScheme.light();
