import 'package:commons/commons/controller/app_store.dart';
import 'package:commons/commons/services/local_database_service_impl.dart';
import 'package:commons/main.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'home_store.dart';

class HomeModule implements Module {
  HomeModule(){
    setInjectors();
  }

  @override
  Map<String, Widget> get routes => {
    NamedRoutes.homePage: const HomePage()
  };
  

  @override
  void setInjectors() {
    injector.registerLazySingleton<HomeStore>(() => HomeStore(
        localDatabaseService: injector.get<LocalDatabaseServiceImpl>(), appStore: injector.get<AppStore>()));
  }
}
