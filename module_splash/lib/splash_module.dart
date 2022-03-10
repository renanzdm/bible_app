import 'package:commons/main.dart';
import 'package:flutter/material.dart';
import 'package:module_splash/splash_page.dart';


class SplashModule implements Module {


  @override
  Map<String, Widget> get routes =>
      {NamedRoutes.splashPage: const SplashPage()};


}
