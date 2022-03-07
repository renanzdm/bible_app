import 'package:commons/commons/controller/app_store.dart';
import 'package:commons/commons/models/version_model.dart';
import 'package:commons/main.dart';
import 'package:flutter/material.dart';


class ConfigVersionsBible extends StatelessWidget {
   ConfigVersionsBible({Key? key}) : super(key: key);

   final AppStore _appStore = injector.get();



  @override
  Widget build(BuildContext context) {
    insertVersionsBible(_appStore, context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Versoes'),
      ),
      body: SizedBox(
        child: ListView.builder(
          itemCount: _appStore.versionsBible.length,
          itemBuilder: (BuildContext context, int index) {
            VersionsModel version = _appStore.versionsBible[index];
            return ListTile(
              onTap: () async {
                await _appStore.changeVersionBible(version);
                Navigator.pushNamedAndRemoveUntil(
                    context, NamedRoutes.splashPage, (Route route) => false);
              },
              title: Text(version.description),
              trailing: _appStore.config.versionBible == version.value
                  ? const Icon(
                Icons.person_outline_outlined,
              )
                  : null,
            );
          },
        ),
      ),
    );
  }

  void insertVersionsBible(AppStore appStore, BuildContext context) {
    _appStore.versionsBible = [
      VersionsModel(
          name: VersionsType.ptNvi,
          value: 'pt_nvi',
          description: 'Português Nova Versao Internacional'),
      VersionsModel(
          name: VersionsType.ptAcf,
          value: 'pt_acf',
          description: 'Português Almeida Corrigida e Revisada Fiél'),
      VersionsModel(
          name: VersionsType.ptAa,
          value: 'pt_aa',
          description: 'Português Almeida Revisada Imprensa Bíblica'),
      VersionsModel(
          name: VersionsType.enBbe,
          value: 'en_bbe',
          description: 'Básico Inglês'),
      VersionsModel(
          name: VersionsType.enKjv,
          value: 'en_kjv',
          description: 'Inglês King James Versão'),
    ];
  }
}
