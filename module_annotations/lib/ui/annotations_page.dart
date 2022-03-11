
import 'package:commons/commons/local_database/local_database_instance.dart';
import 'package:commons/commons/repositories/local_database_repository_impl.dart';
import 'package:commons/commons/services/local_database_service_impl.dart';
import 'package:commons/main.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';
import 'package:module_annotations/services/record_service_impl.dart';
import 'package:module_annotations/services/sound_service_impl.dart';

import 'annotation_controller.dart';
import 'widgets/record_audio_widget/record_audio_controller.dart';
import 'widgets/record_audio_widget/record_audio_widget.dart';

class AnnotationPage extends StatelessWidget {
  const AnnotationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AnnotationController(
            localDatabaseService: LocalDatabaseServiceImpl(
                localDatabaseRepository: LocalDatabaseRepositoryImpl(
                    database: LocalDatabaseInstance())),
            soundService: SoundServiceImpl(myPlayer: FlutterSoundPlayer()),
          ),
        ),
        ChangeNotifierProvider(
            create: (context) => RecordAudioController(
                recordService:
                    RecordServiceImpl(myRecorder: FlutterSoundRecorder()))),
      ],
      child: const AnnotationPageContent(),
    );
  }
}

class AnnotationPageContent extends StatefulWidget {
  const AnnotationPageContent({Key? key}) : super(key: key);

  @override
  State<AnnotationPageContent> createState() => _AnnotationPageContentState();
}

class _AnnotationPageContentState extends State<AnnotationPageContent> {
  late int verseId;
  late AnnotationController _annotationStore;
  int maxLength = 500;
  String textValue = '';

  @override
  void initState() {
    super.initState();
    _annotationStore = context.read<AnnotationController>();

  }

  @override
  void dispose() {
    super.dispose();
    _annotationStore.closeAudioSessionPlayer();
  }

  @override
  Widget build(BuildContext context) {
    verseId = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Anotacao'),
      ),
      body: SizedBox(
          height: SizeOfWidget.sizeFromHeight(context),
          width: SizeOfWidget.sizeFromWidth(context),
          child: Padding(
            padding: ScaffoldPadding.horizontal,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    maxLines: 5,
                    onChanged: (value) {
                      setState(() {
                        textValue = value;
                      });
                    },
                    maxLength: maxLength,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      counter:
                          Text('${textValue.length}/${maxLength.toString()}'),
                    ),
                  ),
                   RecordAudioWidget(verseId: verseId.toString(),),
                  ElevatedButton(
                    onPressed: () async {
                      await _annotationStore.insertAnnotation(
                          verseId: verseId, text: textValue, );
                    },
                    child: const Text('Salvar'),
                  ),
                  // IconButton(
                  //     onPressed: () async {
                  //       await _recordAudioController.startRecorder(id.toString());
                  //     },
                  //     icon: const Icon(Icons.mic)),
                  // IconButton(
                  //     onPressed: () async {
                  //       audioPath = await _recordAudioController.stopRecorder();
                  //     },
                  //     icon: const Icon(Icons.stop)),
                  // IconButton(
                  //     onPressed: () async {
                  //       await _annotationStore.playSound();
                  //     },
                  //     icon: const Icon(Icons.abc_outlined)),
                ],
              ),
            ),
          )),
    );
  }
}
