import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';

import '../record_audio_widget/record_audio_controller.dart';

class TimerRecordWidget extends StatelessWidget {
  const TimerRecordWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RecordingDisposition>(
      stream: context.read<RecordAudioController>().onProgress,
      builder: (context, snapshot) {
        Duration? progress = snapshot.data?.duration;
        String hour = progress?.inHours.toString().padLeft(2, '0') ?? '00';
        String minute =
            progress?.inMinutes.remainder(60).toString().padLeft(2, '0') ??
                '00';
        String second =
            progress?.inSeconds.remainder(60).toString().padLeft(2, '0') ??
                '00';
        return Text(
          hour + ':' + minute + ':' + second,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        );
      },
    );
  }
}