import 'dart:math';

import 'package:commons_dependencies/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module_annotations/services/sound_service/sound_service_impl.dart';
import 'package:module_annotations/ui/widgets/annotation_widget_sound/annotation_sound_controller.dart';

import '../../../model/annotation_model.dart';

class AnnotationWidgetAudio extends StatelessWidget {
  const AnnotationWidgetAudio(
      {Key? key, required this.bookName, required this.annotationModel})
      : super(key: key);

  final String bookName;
  final AnnotationModel annotationModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return AnnotationAudioController(
          soundService: SoundServiceImpl(
            myPlayer: FlutterSoundPlayer(logLevel: Level.error),
          ),
        );
      },
      child: AnnotationWidgetAudioContent(
        annotationModel: annotationModel,
        bookName: bookName,
      ),
    );
  }
}

class AnnotationWidgetAudioContent extends StatefulWidget {
  const AnnotationWidgetAudioContent(
      {Key? key, required this.bookName, required this.annotationModel})
      : super(key: key);

  final String bookName;
  final AnnotationModel annotationModel;

  @override
  State<AnnotationWidgetAudioContent> createState() =>
      _AnnotationWidgetAudioContentState();
}

class _AnnotationWidgetAudioContentState
    extends State<AnnotationWidgetAudioContent> {
  late final AnnotationAudioController controller;

  Future<void> initAudioSession() async {
    await controller.openAudioSessionPlayer();
    await controller.sessionAudio();
    await controller.setDurationUpdateProgress();
  }

  @override
  void initState() {
    super.initState();
    controller = context.read<AnnotationAudioController>();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initAudioSession();
    });
  }

  String formatTime(Duration progress){
    String hour =
    progress.inHours.toString().padLeft(2, '0');
    String minute = progress.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String second = progress.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    return hour + ':' + minute + ':' + second;

  }


  @override
  Widget build(BuildContext context) {
    return Consumer<AnnotationAudioController>(
      builder: (BuildContext context, AnnotationAudioController controller,
          Widget? child) {
        return WillPopScope(
          onWillPop: () async {
            await controller.closeAudioSessionPlayer();
            return true;
          },
          child: Card(
            margin: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Text(
                widget.bookName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              subtitle: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          if (controller.playerState == PlayerState.isPlaying) {
                            await controller.pauseSong();
                          } else if (controller.playerState ==
                              PlayerState.isPaused) {
                            controller.resumeSong();
                          } else {
                            await controller.playSound(
                                path:
                                    widget.annotationModel.audioAnnotationPath);
                          }
                        },
                        icon: Icon(() {
                          switch (controller.playerState) {
                            case PlayerState.isStopped:
                              return Icons.play_arrow;
                            case PlayerState.isPlaying:
                              return Icons.pause;
                            case PlayerState.isPaused:
                              return Icons.play_arrow;
                          }
                        }()),
                      ),
                    ],
                  ),
                  StreamBuilder<PlaybackDisposition?>(
                    stream: controller.progressPlayerSound,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Duration? progress = snapshot.data!.position;
                        Duration? duration = snapshot.data!.duration;
                        if(progress == duration) controller.getPlayerState();
                        double maxDuration =
                           duration.inMilliseconds.toDouble();
                        if (maxDuration <= 0) maxDuration = 0.0;
                        double sliderCurrentPosition = min(
                            progress.inMilliseconds.toDouble(),
                            maxDuration);
                        if (sliderCurrentPosition < 0.0) {
                          sliderCurrentPosition = 0.0;
                        }
                        return Column(
                          children: [
                            CupertinoSlider(
                              max: maxDuration,
                              value: sliderCurrentPosition,
                              min: 0.0,
                              onChanged: (double duration) {
                                controller.seekToPlayer(
                                    duration: Duration(
                                        milliseconds: duration.toInt()));
                              },
                            ),
                            Text(
                              formatTime(duration) +' / '+ formatTime(progress),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
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
