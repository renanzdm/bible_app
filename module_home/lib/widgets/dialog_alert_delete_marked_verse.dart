import 'package:commons/main.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';

import '../home_controller.dart';

class UnmarkedVerseDialog extends StatelessWidget {
  const UnmarkedVerseDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          alignment: Alignment.center,
          width: SizeOfWidget.sizeFromWidth(context, factor: 0.7),
          height: SizeOfWidget.sizeFromHeight(context, factor: .2),
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Deseja Desmarcar esse versiculo ?',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 3.0,
              ),
              DottedLine(
                width: SizeOfWidget.sizeFromWidth(context),
                color: Theme.of(context).backgroundColor,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await context
                            .read<HomeController>()
                            .deleteVerseMarkedOnTable();
                        Navigator.pop(context);
                      },
                      child: const Text('Confirmar')),

                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
