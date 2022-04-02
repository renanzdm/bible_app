
import 'dart:math';

import 'package:commons/commons/utils/sizes.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module_annotations/services/sound_service/sound_service_impl.dart';
import '../../../model/annotation_model.dart';
import 'bloc/widget_player_bloc.dart';

class AnnotationWidget extends StatelessWidget {
  final String bookName;
  final AnnotationModel annotationModel;

  const AnnotationWidget(
      {Key? key, required this.bookName, required this.annotationModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SoundPlayerBloc(
          soundService: SoundServiceImpl(
              myPlayer: FlutterSoundPlayer(logLevel: Level.error)))
        ..add(InitResourceAudio()),
      child: AnnotationWidgetContent(
          annotationModel: annotationModel, bookName: bookName),
    );
  }
}

class AnnotationWidgetContent extends StatefulWidget {
  const AnnotationWidgetContent(
      {Key? key, required this.bookName, required this.annotationModel})
      : super(key: key);

  final String bookName;
  final AnnotationModel annotationModel;

  @override
  State<AnnotationWidgetContent> createState() =>
      _AnnotationWidgetContentState();
}

class _AnnotationWidgetContentState extends State<AnnotationWidgetContent> {
  String formatTime(Duration progress) {
    String hour = progress.inHours.toString().padLeft(2, '0');
    String minute = progress.inMinutes.remainder(60).toString().padLeft(2, '0');
    String second = progress.inSeconds.remainder(60).toString().padLeft(2, '0');
    return hour + ':' + minute + ':' + second;
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoundPlayerBloc, SoundPlayerState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            context.read<SoundPlayerBloc>().add(DisposeResourcesAudio());
            return true;
          },
          child: Card(
            margin: const EdgeInsets.all(16.0),
            elevation: 12.0,
            child: ListTile(
              title: Text(
                widget.bookName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible:
                        widget.annotationModel.audioAnnotationPath.isNotEmpty,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            if (state.playerState == PlayerState.isPlaying) {
                              context.read<SoundPlayerBloc>().add(PauseSong());
                            } else if (state.playerState ==
                                PlayerState.isPaused) {
                              context.read<SoundPlayerBloc>().add(ResumeSong());
                            } else {
                              context.read<SoundPlayerBloc>().add(PlaySound(
                                  pathAudio: widget
                                      .annotationModel.audioAnnotationPath));
                            }
                          },
                          icon: Icon(
                            () {
                              switch (state.playerState) {
                                case PlayerState.isStopped:
                                  return Icons.play_arrow;
                                case PlayerState.isPlaying:
                                  return Icons.pause;
                                case PlayerState.isPaused:
                                  return Icons.play_arrow;
                              }
                            }(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.annotationModel.textAnnotation.isNotEmpty,
                    child: Text(
                      widget.annotationModel.textAnnotation,
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Visibility(
                    visible:
                        widget.annotationModel.audioAnnotationPath.isNotEmpty,
                    child: StreamBuilder<PlaybackDisposition?>(
                      stream: context
                          .watch<SoundPlayerBloc>()
                          .state
                          .playbackProgress,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Duration? progress = snapshot.data!.position;
                          Duration? duration = snapshot.data!.duration;
                          double maxDuration =
                              duration.inMilliseconds.toDouble();
                          double sliderCurrentPosition = min(progress.inMilliseconds.toDouble(), duration.inMilliseconds.toDouble());
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: SizeOfWidget.sizeFromWidth(context),
                                child: CupertinoSlider(
                                  max: maxDuration,
                                  value: sliderCurrentPosition,
                                  min: 0.0,
                                  onChanged: (double duration) {
                                    context.read<SoundPlayerBloc>().add(
                                        SeekPlayer(
                                            duration: Duration(
                                                milliseconds:
                                                    duration.toInt())));
                                  },
                                ),
                              ),
                              Text(
                                formatTime(duration) +
                                    ' / ' +
                                    formatTime(progress),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
