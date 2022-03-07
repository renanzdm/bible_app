// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStore, Store {
  final _$configAtom = Atom(name: '_AppStore.config');

  @override
  ConfigModel get config {
    _$configAtom.reportRead();
    return super.config;
  }

  @override
  set config(ConfigModel value) {
    _$configAtom.reportWrite(value, super.config, () {
      super.config = value;
    });
  }

  final _$bibleModelAtom = Atom(name: '_AppStore.bibleModel');

  @override
  BibleModel get bibleModel {
    _$bibleModelAtom.reportRead();
    return super.bibleModel;
  }

  @override
  set bibleModel(BibleModel value) {
    _$bibleModelAtom.reportWrite(value, super.bibleModel, () {
      super.bibleModel = value;
    });
  }

  @override
  String toString() {
    return '''
config: ${config},
bibleModel: ${bibleModel}
    ''';
  }
}
