import 'dart:async';

import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';
import 'package:module_annotations/ui/widgets/record_audio_widget/bloc/record_audio_bloc.dart';

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
        if (context.read<RecordAudioBloc>().state.stopWatch.isRunning) {
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
    Duration? progress =
        context.watch<RecordAudioBloc>().state.stopWatch.elapsed;
    String hour = progress.inHours.toString().padLeft(2, '0');
    String minute = progress.inMinutes.remainder(60).toString().padLeft(2, '0');
    String second = progress.inSeconds.remainder(60).toString().padLeft(2, '0');
    return Text(
      hour + ':' + minute + ':' + second,
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}
