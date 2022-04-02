import 'package:commons/commons/controller/app_controller.dart';
import 'package:commons/commons/local_database/local_database_instance.dart';
import 'package:commons/commons/repositories/local_database_repository_impl.dart';
import 'package:commons/commons/services/local_database_service_impl.dart';
import 'package:commons/main.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';
import 'package:module_annotations/model/annotation_model.dart';
import 'package:module_annotations/ui/bloc/annotations_bloc.dart';
import 'package:module_annotations/ui/widgets/annotation_widget_sound/annotation_widget.dart';
import 'package:module_annotations/utils/utils.dart';
import '../services/record_service/record_service_impl.dart';

import 'widgets/record_audio_widget/bloc/record_audio_bloc.dart';
import 'widgets/record_audio_widget/bloc/record_audio_event.dart';
import 'widgets/record_audio_widget/record_audio_widget.dart';

class AnnotationPage extends StatelessWidget {
  const AnnotationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AnnotationsBloc>(
          create: (context) => AnnotationsBloc(
            localDatabaseService: LocalDatabaseServiceImpl(
              localDatabaseRepository: LocalDatabaseRepositoryImpl(
                database: LocalDatabaseInstance(),
              ),
            ),
          )..add(GetPermissions()),
        ),
        BlocProvider<RecordAudioBloc>(
            create: (context) => RecordAudioBloc(
                recordService: RecordServiceImpl(
                    myRecorder: FlutterSoundRecorder(logLevel: Level.error)))
              ..add(LoadResourcesAudio())),
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
  late AppController _appController;
  int maxLength = 500;

  @override
  void initState() {
    super.initState();
    _appController = context.read<AppController>();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    verseId = ModalRoute.of(context)?.settings.arguments as int;
    context.read<AnnotationsBloc>().add(GetAnnotations(id: verseId.toString()));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Anotacao'),
      ),
      body: BlocBuilder<AnnotationsBloc, AnnotationsState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Visibility(
                        visible:
                            context.watch<AnnotationsBloc>().state.status ==
                                AnnotationStats.loading,
                        child: const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                      Visibility(
                        visible: state.status == AnnotationStats.success,
                        child: Padding(
                          padding: ScaffoldPadding.horizontal,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextField(
                                maxLines: 5,
                                onChanged: (String text) {
                                  context.read<AnnotationsBloc>().add(
                                      SetTextAnnotation(textAnnotation: text));
                                },
                                maxLength: maxLength,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  counter: Text(
                                      '${context.read<AnnotationsBloc>().state.text.length}/${maxLength.toString()}'),
                                ),
                              ),
                              RecordAudioWidget(
                                verseId: verseId.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ...state.listAnnotations
                          .map(
                            (AnnotationModel annotation) => Visibility(
                              visible: context
                                  .watch<RecordAudioBloc>()
                                  .state
                                  .isStopped,
                              child: AnnotationWidget(
                                annotationModel: annotation,
                                bookName: Utils.getNameBook(
                                    idBook: annotation.bookId,
                                    bibleModel: _appController.bibleModel),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: state.text.isNotEmpty ||
                    context
                        .watch<RecordAudioBloc>()
                        .state
                        .pathAudioSaved
                        .isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        SizeOfWidget.sizeFromWidth(context, factor: .8),
                        40,
                      ),
                    ),
                    onPressed: context.watch<RecordAudioBloc>().state.isStopped
                        ? () async {
                            context.read<AnnotationsBloc>().add(SetPathAudio(
                                pathAudio: context
                                    .read<RecordAudioBloc>()
                                    .state
                                    .pathAudioSaved));
                            context
                                .read<RecordAudioBloc>()
                                .add(ClearPathAudioAfterSaved());
                            context
                                .read<AnnotationsBloc>()
                                .add(InsertAnnotations(verseId: verseId));
                            context
                                .read<AnnotationsBloc>()
                                .add(const ClearAnnotation());
                            context
                                .read<AnnotationsBloc>()
                                .add(GetAnnotations(id: verseId.toString()));
                          }
                        : null,
                    child: Text(
                      'Salvar',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
