import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
    this.height = kToolbarHeight,
    this.actions = const [],

  }) : super(key: key);
  final double height;
  final List<Widget> actions;


  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      actions: [
        ...actions,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
