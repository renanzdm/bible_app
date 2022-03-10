
import 'package:commons/main.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class HomeModule implements Module {


  @override
  Map<String, Widget> get routes => {
    NamedRoutes.homePage: const HomePage()
  };
  

}
