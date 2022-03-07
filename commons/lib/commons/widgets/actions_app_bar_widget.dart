import 'package:flutter/material.dart';

class ActionsAppBarWidget extends StatelessWidget {
  const ActionsAppBarWidget(
      {Key? key,
      required this.width,
      this.borderColor = Colors.white,
      required this.text,
     this.fontSize = 14,this.onTap})
      : super(key: key);
  final double width;
  final Color borderColor;
  final String text;
  final double fontSize;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        padding: const EdgeInsets.all(4),
        alignment: Alignment.center,
        child: Text(
          text,overflow: TextOverflow.ellipsis,
          style:  TextStyle(fontSize: fontSize),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: borderColor, width: 2),
        ),
        height: 50,
        width: width,
      ),
    );
  }
}
