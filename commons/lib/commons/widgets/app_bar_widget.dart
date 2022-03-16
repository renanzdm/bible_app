import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
    this.height = kToolbarHeight,
    this.actions = const [],
  required  this.onTapLeading
  }) : super(key: key);
  final double height;
  final List<Widget> actions;
 final VoidCallback onTapLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Platform.isAndroid
          ? IconButton(onPressed: onTapLeading, icon: const Icon(Icons.arrow_back))
          : IconButton(onPressed: onTapLeading, icon: const Icon(Icons.arrow_back_ios_outlined)),
      toolbarHeight: height,
      actions: [
        ...actions,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
