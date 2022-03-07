import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  const DottedLine({Key? key, required this.width, this.color = Colors.white}) : super(key: key);
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomPaint(
        size: Size(width, 0.0),
        painter: LinePaint(color),
      ),
    );
  }
}

class LinePaint extends CustomPainter {
  final Color color;
  LinePaint(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke..strokeWidth= 2.0;

    for (double i = 0.0; i <= size.width; i+=4) {
      if(i%3==0) {
        canvas.drawLine(Offset(i, 0.0), Offset(i+10, 0.0), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
