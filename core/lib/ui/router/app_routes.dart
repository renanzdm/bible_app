

import 'package:flutter/material.dart';
import 'package:module_annotations/annotations_module.dart';
import 'package:module_config_versions/config_versions_module.dart';
import 'package:module_home/home_module.dart';
import 'package:module_splash/splash_module.dart';
import 'package:module_summary/summary_module.dart';


class AppRoutes {

  static Map<String, Widget> routes = {
    ...SplashModule().routes,
    ...SummaryModule().routes,
    ...HomeModule().routes,
    ...ConfigVersionsModule().routes,
    ...AnnotationModule().routes,
  };
}
