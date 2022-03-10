
import 'package:commons/commons/controller/app_controller.dart';
import 'package:commons/commons/local_database/local_database_instance.dart';
import 'package:commons/commons/repositories/local_database_repository_impl.dart';
import 'package:commons/commons/services/local_database_service_impl.dart';
import 'package:commons/main.dart';
import 'package:flutter/material.dart';

class AppModule implements Module {

  @override
  Map<String, Widget> get routes => {};

  @override
  void setInjectors() {
    //
    //
    // injector.registerLazySingleton<LocalDatabaseInstance>(
    //     () => LocalDatabaseInstance());
    // injector.registerLazySingleton<LocalDatabaseServiceImpl>(() =>
    //     LocalDatabaseServiceImpl(
    //         localDatabaseRepository: LocalDatabaseRepositoryImpl(
    //             database: injector.get<LocalDatabaseInstance>())));
    // injector.registerLazySingleton(
    //     () => AppController(localService: injector.get<LocalDatabaseServiceImpl>()));
  }


}
