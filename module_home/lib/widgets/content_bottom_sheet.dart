import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ContentBottomSheet extends StatelessWidget {
  final Function(Color) onTap;
  final Color color;
  const ContentBottomSheet({Key? key, required this.onTap, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlockPicker(
      useInShowDialog: true,
      pickerColor: color,
      onColorChanged: onTap,
      layoutBuilder: (context, colors, child) {
        return Container(
          margin: const EdgeInsets.only(right: 16, left: 16, bottom: 22),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(32),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(32),
            ),
            child: GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: colors.map((color) => child(color)).toList(),
            ),
          ),
        );
      },
    );
  }
}
