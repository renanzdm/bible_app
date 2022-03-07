import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ThemeModesController extends ChangeNotifier {
  bool isDark = false;

  void changeThemeMode() {
    isDark = !isDark;
    notifyListeners();
  }
}
