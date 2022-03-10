import 'package:commons/main.dart';
import 'package:flutter/material.dart';

import 'annotations_page.dart';

class AnnotationModule implements Module {


  @override
  Map<String, Widget> get routes => {
        NamedRoutes.annotationPage: const AnnotationPage(),
      };
}
