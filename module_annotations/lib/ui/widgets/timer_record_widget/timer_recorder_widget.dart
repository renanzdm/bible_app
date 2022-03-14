import 'dart:async';

import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';
import '../record_audio_widget/record_audio_controller.dart';

class TimerRecordWidget extends StatefulWidget {
  const TimerRecordWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TimerRecordWidget> createState() => _TimerRecordWidgetState();
}

class _TimerRecordWidgetState extends State<TimerRecordWidget> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (context.read<RecordAudioController>().timer.isRunning) {
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordAudioController>(
        builder: (context, RecordAudioController value, child) {
      Duration? progress = value.timer.elapsed;
      String hour = progress.inHours.toString().padLeft(2, '0');
      String minute =
          progress.inMinutes.remainder(60).toString().padLeft(2, '0');
      String second =
          progress.inSeconds.remainder(60).toString().padLeft(2, '0');
      return Text(
        hour + ':' + minute + ':' + second,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      );
    });
  }
}

// return StreamBuilder<RecordingDisposition>(
// stream: context.read<RecordAudioController>().onProgress,
// builder: (context, snapshot) {
// log(snapshot.data?.duration.inMilliseconds.toString() ??'');
// Duration? progress = snapshot.data?.duration;
// String hour = progress?.inHours.toString().padLeft(2, '0') ?? '00';
// String minute =
// progress?.inMinutes.remainder(60).toString().padLeft(2, '0') ??
// '00';
// String second =
// progress?.inSeconds.remainder(60).toString().padLeft(2, '0') ??
// '00';
// return Text(
// hour + ':' + minute + ':' + second,
// style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
// );
// },
// );
