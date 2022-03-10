import 'package:commons/commons/controller/app_controller.dart';
import 'package:commons/commons/local_database/local_database_instance.dart';
import 'package:commons/commons/repositories/local_database_repository_impl.dart';
import 'package:commons/commons/services/local_database_service_impl.dart';
import 'package:commons/main.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';

import 'ui/router/route_builder.dart';
import 'ui/theme/theme_app.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppController(
            localService: LocalDatabaseServiceImpl(
              localDatabaseRepository: LocalDatabaseRepositoryImpl(
                database: LocalDatabaseInstance(),
              ),
            ),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            title: 'Biblia App',
            theme: ThemeApp.theme(context),
            initialRoute: NamedRoutes.splashPage,
            onGenerateRoute: RouteBuilder.routes,
          );
        }
      ),
    );
  }
}
