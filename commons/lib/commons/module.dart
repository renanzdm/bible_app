import 'package:flutter/material.dart';

abstract class Module {
  final Map<String, Widget> routes;
  Module({
    this.routes = const {},  
  });
  void setInjectors();
}



