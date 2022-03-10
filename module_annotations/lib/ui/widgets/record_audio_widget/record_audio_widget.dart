import 'package:flutter/material.dart';
import 'package:commons/commons/utils/sizes.dart';
import '../../annotation_controller.dart';
import 'record_audio_controller.dart';
import 'package:commons_dependencies/main.dart';

class RecordAudioWidget extends StatefulWidget {
  const RecordAudioWidget({Key? key, required this.verseId}) : super(key: key);
  final String verseId;

  @override
  State<RecordAudioWidget> createState() => _RecordAudioWidgetState();
}

class _RecordAudioWidgetState extends State<RecordAudioWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late RecordAudioController _recordAudioController;
  late AnnotationController _annotationStore;

  @override
  void initState() {
    super.initState();
    _recordAudioController = context.read<RecordAudioController>();
    _annotationStore = context.read<AnnotationController>();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),lowerBound: 2,upperBound: 4
        );
    _animationController.addListener(() {
      if (_animationController.value == _animationController.upperBound) {
        _animationController.reverse();
      } else if (_animationController.value ==
          _animationController.lowerBound) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.removeListener(() {});
    _animationController.dispose();
    _recordAudioController.closeAudioRecordSession();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return CustomPaint(
          painter: CurlingRecordAudio(_animationController.value),
          child: Consumer<RecordAudioController>(
            builder: (BuildContext context, RecordAudioController value,
                Widget? child) {
              return Container(
                height: SizeOfWidget.sizeFromHeight(context, factor: .25),
                width: SizeOfWidget.sizeFromHeight(context, factor: .25),
                margin: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.deepPurple),
                child: GestureDetector(
                  onTap: () async {
                    if (value.isRecorder) {
                     _animationController.stop();
                      _annotationStore.pathAudioCurrent =
                          await value.stopRecorder();

                    } else {
                      _animationController.forward();
                      await value.startRecorder(widget.verseId);

                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        value.isRecorder ? Icons.stop : Icons.mic,
                        color: Colors.white,
                        size: 50,
                      ),
                      StreamBuilder<RecordingDisposition>(
                        stream: value.onProgress,
                        builder: (context, snapshot) {
                          Duration? progress = snapshot.data?.duration;
                          String hour = progress?.inHours.toString().padLeft(2,'0') ??'00';
                          String minute = progress?.inMinutes.remainder(60).toString().padLeft(2,'0') ??'00';
                          String second = progress?.inSeconds.remainder(60).toString().padLeft(2,'0') ??'00';
                          return Text(
                            hour+':'+minute+':'+second,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class CurlingRecordAudio extends CustomPainter {
  final double animation;

  CurlingRecordAudio(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..color = Colors.red
      ..strokeWidth = animation
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset(size.height / 2, size.width / 2), size.height/2, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
