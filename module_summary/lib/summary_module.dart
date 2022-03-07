import 'package:commons/main.dart';
import 'package:flutter/material.dart';


import 'summary_page.dart';
import 'summary_store.dart';

class SummaryModule implements Module {


  SummaryModule(){
  setInjectors();
}
  @override
  Map<String, Widget> get routes => {NamedRoutes.summaryPage: const SummaryPage()};


  @override
  void setInjectors() {
  injector.registerLazySingleton<SummaryStore>(() => SummaryStore());

  }
}
