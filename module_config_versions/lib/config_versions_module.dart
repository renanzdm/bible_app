import 'package:commons/main.dart';
import 'package:flutter/material.dart';
import 'package:module_config_versions/config_versions_store.dart';

import 'config_versions_page.dart';

class ConfigVersionsModule implements Module {
  ConfigVersionsModule() {
    setInjectors();
  }

  @override
  Map<String, Widget> get routes => {
        NamedRoutes.configVersionsPage: ConfigVersionsBible(),
      };

  @override
  void setInjectors() {
    injector.registerLazySingleton(
        () => ConfigVersionsStore());
  }
}
