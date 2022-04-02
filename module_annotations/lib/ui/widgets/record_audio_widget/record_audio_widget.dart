import 'package:flutter/material.dart';
import 'package:commons/commons/utils/sizes.dart';
import 'package:module_annotations/ui/widgets/record_audio_widget/bloc/record_audio_bloc.dart';
import 'package:module_annotations/ui/widgets/record_audio_widget/bloc/record_audio_state.dart';
import '../decibels_widget/decibels_widget.dart';
import '../timer_record_widget/timer_recorder_widget.dart';
import 'bloc/record_audio_event.dart';
import 'package:commons_dependencies/main.dart';



class RecordAudioWidget extends StatelessWidget {
  const RecordAudioWidget({Key? key, required this.verseId})
      : super(key: key);
  final String verseId;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        context.read<RecordAudioBloc>().add(DisposeResourcesAudio());
        return true;
      },
      child: BlocConsumer<RecordAudioBloc, RecordAudioState>(
        listener: (context, state) {},
        builder: (BuildContext context, RecordAudioState state) {
          return Column(
            children: [
              const TimerRecordWidget(),
              Row(
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
                        if (state.isPaused) {
                          context.read<RecordAudioBloc>().add(ResumeRecorder());
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
                        if (state.isRunning) {
                          context.read<RecordAudioBloc>().add(StopRecorder());
                        } else if (state.isStopped) {
                          context.read<RecordAudioBloc>().add(StartRecorder());
                        }
                      },
                      child: Visibility(
                        visible: state.isRunning,
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
                        if (state.isRunning) {
                          context.read<RecordAudioBloc>().add(PauseRecorder());
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
              ),
              const SizedBox(
                height: 60,
              ),
              Visibility(
                visible: state.isRunning,
                child: DecibelsWidget(),
              ),
            ],
          );
        },
      ),
    );
  }
}
