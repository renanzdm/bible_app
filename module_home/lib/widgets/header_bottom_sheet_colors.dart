import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';

class HeaderBottomSheetColors extends StatelessWidget {
  final Animation<double> animation;
  const HeaderBottomSheetColors({Key? key, required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedIcon(
              onTap: () {
                context.read<HomeBloc>().add(const ActiveAnimation(active: false));
                Navigator.of(context).pop();
              },
              color: Colors.white,
              icon: Icons.keyboard_arrow_down_rounded,
              animation: animation,
            ),
          ],
        );
      },
    );
  }
}

class AnimatedIcon extends AnimatedWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  const AnimatedIcon(
      {Key? key,
      required this.icon,
      required this.color,
      this.onTap,
      required Animation<double> animation})
      : super(key: key, listenable: animation);

  Animation<double> get _anim => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        return GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 40,
            width: 40,
            child: Transform.translate(
              offset: Offset(0.0, (_anim.value * 5)),
              child: Icon(icon, size: 35, color: color),
            ),
          ),
        );
      },
    );
  }
}
