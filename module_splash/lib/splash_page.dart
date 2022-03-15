import 'package:commons/commons/controller/app_controller.dart';
import 'package:commons/main.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';
import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashController _splashStore;

  late AppController _appStore;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) async {
      _appStore = context.read<AppController>();
      await _appStore.createTables();
      await _appStore.insertValueDefaultOnConfigTable();
      await _appStore.configureVersionsBible();
      await Future.delayed(const Duration(milliseconds: 100));
      Navigator.pushReplacementNamed(context, NamedRoutes.summaryPage);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashController()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            color: Colors.deepPurpleAccent,
            child: Consumer(
              builder: (BuildContext context, SplashController value, child) {
                return AnimatedOpacity(
                  opacity: value.opacity ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 4000),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeOfWidget.sizeFromWidth(context, factor: 0.3),
                        height:
                            SizeOfWidget.sizeFromHeight(context, factor: 0.3),
                        child: Image.asset('assets/images/logo_bible.png'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
