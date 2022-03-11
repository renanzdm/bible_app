import 'dart:math';

import 'package:flutter/material.dart';
import 'package:commons/commons/utils/sizes.dart';
import 'package:module_annotations/model/wave_model.dart';
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
          builder: (BuildContext context, value, Widget? child) {
            return Container(
              height: SizeOfWidget.sizeFromHeight(context, factor: .1),
              width: SizeOfWidget.sizeFromHeight(context, factor: .1),
              margin: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.red),
              child: GestureDetector(
                onTap: () async {
                  if (value.isRecorder) {
                    _annotationStore.pathAudioCurrent =
                        await value.stopRecorder();
                  } else {
                    await value.startRecorder(widget.verseId);
                  }
                },
                child: Icon(
                  value.isRecorder ? Icons.stop : Icons.mic,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            );
          },
        ),
        DecibelsWidget()

      ],
    );
  }
}
