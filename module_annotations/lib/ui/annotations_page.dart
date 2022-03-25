import 'package:commons/commons/controller/app_controller.dart';
import 'package:commons/commons/local_database/local_database_instance.dart';
import 'package:commons/commons/repositories/local_database_repository_impl.dart';
import 'package:commons/commons/services/local_database_service_impl.dart';
import 'package:commons/main.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';
import 'package:module_annotations/model/annotation_model.dart';
import 'package:module_annotations/services/record_service/record_service_impl.dart';
import 'package:module_annotations/services/sound_service/sound_service_impl.dart';
import 'package:module_annotations/ui/widgets/annotation_widget_sound/annotation_sound_controller.dart';
import 'package:module_annotations/ui/widgets/annotation_widget_sound/annotation_widget_audio.dart';
import 'package:module_annotations/utils/utils.dart';
import 'annotation_controller.dart';
import 'widgets/annotation_widget_text/annotation_widget_text.dart';
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
          ),
        ),
        ChangeNotifierProvider(
            create: (context) => RecordAudioController(
                recordService: RecordServiceImpl(
                    myRecorder: FlutterSoundRecorder(logLevel: Level.error)))),
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
  late AppController _appController;
  int maxLength = 500;
  String textValue = '';



  @override
  void initState() {
    super.initState();
    _annotationStore = context.read<AnnotationController>();
    _appController = context.read<AppController>();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _annotationStore.getAnnotations(id: verseId.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    verseId = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Anotacao'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: ScaffoldPadding.horizontal,
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
                            counter: Text(
                                '${textValue.length}/${maxLength.toString()}'),
                          ),
                        ),
                        RecordAudioWidget(
                          verseId: verseId.toString(),
                        ),
                      ],
                    ),
                  ),
                  ..._annotationStore.listAnnotations
                      .map(
                        (AnnotationModel annotation) => Visibility(
                          visible: annotation.audioAnnotationPath.isEmpty,
                          child: AnnotationWidgetText(
                            annotationModel: annotation,
                            bookName: Utils.getNameBook(
                                idBook: annotation.bookId,
                                bibleModel: _appController.bibleModel),
                          ),
                          replacement: AnnotationWidgetAudio(
                            bookName: Utils.getNameBook(
                                idBook: annotation.bookId,
                                bibleModel: _appController.bibleModel),
                            annotationModel: annotation,
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
          if (textValue.isNotEmpty ||
              context.watch<AnnotationController>().pathAudioCurrent.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                  SizeOfWidget.sizeFromWidth(context),
                  40,
                )),
                onPressed: () async {
                  await _annotationStore.insertAnnotation(
                    verseId: verseId,
                    text: textValue,
                  );
                },
                child: Text(
                  'Salvar',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
