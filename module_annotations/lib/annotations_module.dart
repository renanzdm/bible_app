import 'package:commons/commons/services/local_database_service_impl.dart';
import 'package:commons/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:module_annotations/services/sound_service_impl.dart';
import 'annotation_store.dart';
import 'annotations_page.dart';

class AnnotationModule implements Module {

  AnnotationModule() {
    setInjectors();
  }

  @override
  Map<String, Widget> get routes => {
        NamedRoutes.annotationPage: const AnnotationPage(),
      };

  @override
  void setInjectors() {
    injector.registerLazySingleton<AnnotationStore>(
      () => AnnotationStore(
        localDatabaseService: injector.get<LocalDatabaseServiceImpl>(),
        soundService: SoundServiceImpl(
          myRecorder: FlutterSoundRecorder(),
          myPlayer: FlutterSoundPlayer(),
        ),
      ),
    );
  }
}
