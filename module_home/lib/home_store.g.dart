// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$versesListAtom = Atom(name: '_HomeStore.versesList');

  @override
  ObservableList<VerseModel> get versesList {
    _$versesListAtom.reportRead();
    return super.versesList;
  }

  @override
  set versesList(ObservableList<VerseModel> value) {
    _$versesListAtom.reportWrite(value, super.versesList, () {
      super.versesList = value;
    });
  }

  final _$pickerColorAtom = Atom(name: '_HomeStore.pickerColor');

  @override
  Color get pickerColor {
    _$pickerColorAtom.reportRead();
    return super.pickerColor;
  }

  @override
  set pickerColor(Color value) {
    _$pickerColorAtom.reportWrite(value, super.pickerColor, () {
      super.pickerColor = value;
    });
  }

  final _$changeThemeAsyncAction = AsyncAction('_HomeStore.changeTheme');

  @override
  Future<void> changeTheme() {
    return _$changeThemeAsyncAction.run(() => super.changeTheme());
  }

  final _$addVerseMarkedOnTableAsyncAction =
      AsyncAction('_HomeStore.addVerseMarkedOnTable');

  @override
  Future<void> addVerseMarkedOnTable(VersesMarkedModel versesMarkedModel) {
    return _$addVerseMarkedOnTableAsyncAction
        .run(() => super.addVerseMarkedOnTable(versesMarkedModel));
  }

  final _$increaseFontSizeAsyncAction =
      AsyncAction('_HomeStore.increaseFontSize');

  @override
  Future<void> increaseFontSize() {
    return _$increaseFontSizeAsyncAction.run(() => super.increaseFontSize());
  }

  final _$decreaseFontSizeAsyncAction =
      AsyncAction('_HomeStore.decreaseFontSize');

  @override
  Future<void> decreaseFontSize() {
    return _$decreaseFontSizeAsyncAction.run(() => super.decreaseFontSize());
  }

  final _$getVersesMarkedOnTableAsyncAction =
      AsyncAction('_HomeStore.getVersesMarkedOnTable');

  @override
  Future<void> getVersesMarkedOnTable() {
    return _$getVersesMarkedOnTableAsyncAction
        .run(() => super.getVersesMarkedOnTable());
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void changeColor(Color color) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.changeColor');
    try {
      return super.changeColor(color);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDefaultValuesBible(
      {required VerseModel verseModel,
      required ChapterModel chapterModel,
      required BookModel bookModel}) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setDefaultValuesBible');
    try {
      return super.setDefaultValuesBible(
          verseModel: verseModel,
          chapterModel: chapterModel,
          bookModel: bookModel);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setVerseModelSelected({required int index}) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setVerseModelSelected');
    try {
      return super.setVerseModelSelected(index: index);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
versesList: ${versesList},
pickerColor: ${pickerColor}
    ''';
  }
}
