import 'package:flutter/material.dart';

import 'app_routes.dart';

class RouteBuilder {
  static Route<dynamic> routes(RouteSettings settings) {
    return PageRouteBuilder(
      settings:
          RouteSettings(name: settings.name, arguments: settings.arguments),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return AppRoutes.routes[settings.name]!;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        const Offset begin = Offset(1.0, 0.0);
        const Offset end = Offset.zero;
        final Tween<Offset> tween = Tween(begin: begin, end: end);
        final Animation<Offset> offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
