import 'package:commons/main.dart';
import 'package:flutter/material.dart';
import 'summary_page.dart';

class SummaryModule implements Module {

  @override
  Map<String, Widget> get routes => {NamedRoutes.summaryPage: const SummaryPage()};


}
