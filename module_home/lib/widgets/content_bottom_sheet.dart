import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ContentBottomSheet extends StatelessWidget {
  final Function(Color) onTap;
  final Color color;
  const ContentBottomSheet({Key? key, required this.onTap, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlockPicker(
        pickerColor: color,
        onColorChanged: onTap,
        layoutBuilder: (context, colors, child) {
          return SizedBox(
            width: 300,
            child: GridView.count(
              padding:EdgeInsets.zero,
              crossAxisCount: 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: colors.map((color) => child(color)).toList(),
            ),
          );
        },
      ),
    );
  }
}
