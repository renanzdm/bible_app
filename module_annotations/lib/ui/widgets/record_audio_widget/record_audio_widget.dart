import 'package:flutter/material.dart';
import 'package:commons/commons/utils/sizes.dart';
import '../../annotation_controller.dart';
import '../decibels_widget/decibels_widget.dart';
import '../timer_record_widget/timer_recorder_widget.dart';
import 'record_audio_controller.dart';
import 'package:commons_dependencies/main.dart';

class RecordAudioWidget extends StatefulWidget {
  const RecordAudioWidget({Key? key, required this.verseId}) : super(key: key);
  final String verseId;

  @override
  State<RecordAudioWidget> createState() => _RecordAudioWidgetState();
}

class _RecordAudioWidgetState extends State<RecordAudioWidget> {
  late RecordAudioController _recordAudioController;
  late AnnotationController _annotationStore;

  @override
  void initState() {
    super.initState();
    _recordAudioController = context.read<RecordAudioController>();
    _annotationStore = context.read<AnnotationController>();
  }

  @override
  void dispose() {
    super.dispose();
    _recordAudioController.closeAudioRecordSession();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TimerRecordWidget(),
        Consumer<RecordAudioController>(
          builder: (BuildContext context, RecordAudioController value,
              Widget? child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: SizeOfWidget.sizeFromHeight(context, factor: .07),
                  width: SizeOfWidget.sizeFromHeight(context, factor: .07),
                  margin: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                  child: GestureDetector(
                    onTap: () async {
                      if (!value.isRecorder) {
                        await value.resumeRecorder();
                      }
                    },
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  height: SizeOfWidget.sizeFromHeight(context, factor: .1),
                  width: SizeOfWidget.sizeFromHeight(context, factor: .1),
                  margin: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                  child: GestureDetector(
                    onTap: () async {
                      value.getIsStopped();
                      if (value.isRecorder) {
                        _annotationStore
                            .setAudioPath(await value.stopRecorder() ?? '');
                      } else if (value.isStopped) {
                        await value.startRecorder(widget.verseId);
                      }
                    },
                    child: Visibility(
                      visible: value.isRecorder,
                      child: const Icon(
                        Icons.stop,
                        color: Colors.white,
                        size: 30,
                      ),
                      replacement: const Icon(
                        Icons.mic,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: SizeOfWidget.sizeFromHeight(context, factor: .07),
                  width: SizeOfWidget.sizeFromHeight(context, factor: .07),
                  margin: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                  child: GestureDetector(
                    onTap: () async {
                      if (value.isRecorder) {
                        await value.pauseRecorder();
                      }
                    },
                    child: const Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 60,
        ),
        DecibelsWidget()
      ],
    );
  }
}
