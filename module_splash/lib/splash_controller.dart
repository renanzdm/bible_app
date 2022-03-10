import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';

class SplashController extends ChangeNotifier implements ReassembleHandler {
  SplashController() {
    changeOpacity();
  }

  bool opacity = false;

  void changeOpacity() async {
    opacity = true;
    notifyListeners();
  }

  @override
  void reassemble() {
    debugPrint('not hot-reload SplashController');
  }
}
