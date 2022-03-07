import 'package:commons/main.dart';
import 'package:flutter/material.dart';
import 'package:module_splash/splash_page.dart';

import 'splash_store.dart';

class SplashModule implements Module {
  SplashModule() {
    setInjectors();
  }

  @override
  Map<String, Widget> get routes =>
      {NamedRoutes.splashPage: const SplashPage()};

  @override
  void setInjectors() {
    injector.registerLazySingleton<SplashStore>(() => SplashStore());
  }
}
