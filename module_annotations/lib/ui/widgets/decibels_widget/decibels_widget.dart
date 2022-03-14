import 'package:commons/commons/utils/sizes.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';
import 'package:module_annotations/ui/widgets/record_audio_widget/record_audio_controller.dart';

class DecibelsWidget extends StatelessWidget {
  DecibelsWidget({
    Key? key,
  }) : super(key: key);

  final List<double> listDecibels = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RecordingDisposition>(
      stream: context.read<RecordAudioController>().onProgress,
      builder: (context, snapshot) {
        if(listDecibels.length> SizeOfWidget.sizeFromWidth(context)){
          listDecibels.removeAt(0);
        }
        listDecibels.add(snapshot.data?.decibels ?? 0.0);
        return CustomPaint(
          painter: DecibelsRecordAudioPainter(listDecibels),
          size: Size(SizeOfWidget.sizeFromWidth(context), 100),
          isComplex: true,
        );
      },
    );
  }
}

class DecibelsRecordAudioPainter extends CustomPainter {
  final List<double> listDecibels;

  DecibelsRecordAudioPainter(this.listDecibels);

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    double x = 0.0;
    for (double item in listDecibels) {
      canvas.drawLine(Offset(x, item), Offset(x, -item), _paint);
      x++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
