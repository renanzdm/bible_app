
import 'package:commons/commons/controller/app_store.dart';
import 'package:commons/main.dart';
import 'package:flutter/material.dart';


import 'splash_store.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>{
  final SplashStore _splashStore = injector.get<SplashStore>();
  final  AppStore _appStore = injector.get<AppStore>();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) async {
      await _appStore.createTables();
      await _appStore.insertValueDefaultOnConfigTable();
      await _appStore.configureVersionsBible();
      await _splashStore.changeOpacity();
      Navigator.pushReplacementNamed(context, NamedRoutes.summaryPage);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.deepPurpleAccent,
        child: ValueListenableBuilder<bool>(
          valueListenable: _splashStore.opacity,
          builder: (BuildContext context, bool value, Widget? child) {
            return AnimatedOpacity(
              opacity: value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 4000),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeOfWidget.sizeFromWidth(context, factor: 0.3),
                    height: SizeOfWidget.sizeFromHeight(context, factor: 0.3),
                    child: Image.asset('assets/images/logo_bible.png'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


}
