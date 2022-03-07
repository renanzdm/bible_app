
import 'package:commons/commons/controller/app_store.dart';
import 'package:commons/main.dart';
import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData theme(BuildContext context) {
AppStore _appStore = injector.get<AppStore>();
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
