import 'package:commons/main.dart';
import 'package:flutter/material.dart';

import 'config_versions_page.dart';

class ConfigVersionsModule implements Module {


  @override
  Map<String, Widget> get routes =>
      {
        NamedRoutes.configVersionsPage: ConfigVersionsBible(),
      };
}
