import 'package:flutter/material.dart';

class SizeOfWidget {
  static double sizeFromHeight(BuildContext context, {double factor = 1.0}) =>
      MediaQuery.of(context).size.height*factor;
  static double sizeFromWidth(BuildContext context, {double factor = 1.0}) =>
      MediaQuery.of(context).size.width*factor;
}
