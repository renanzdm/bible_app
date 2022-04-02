import 'package:commons/commons/models/book_model.dart';
import 'package:commons/commons/models/chapter_model.dart';
import 'package:commons/commons/models/verse_model.dart';
import 'package:commons/commons/services/local_database_service.dart';
import 'package:commons/main.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter/material.dart';

import '../models/verses_marked_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required LocalDatabaseService localDatabaseService})
      : _localService = localDatabaseService,
        super(const HomeState()) {
    on<ChangeColor>(_changeColor);
    on<SetIndexVerseClicked>(_setIndexVerseClicked);
    on<SetDefaultValuesBible>(_setDefaultValuesBible);
    on<ConfigureVersesMarked>(_configureVersesMarked);
    on<SetVerseSelected>(_setVerseSelected);
    on<ChangeVerseMarkedStatus>(_changeVerseMarkedStatus);
    on<AddVerseMarkedOnTable>(_addVerseMarkedOnTable);
    on<UpdateColorVerseMarked>(_updateColorVerseMarked);
    on<DeleteVerseMarkedOnTable>(_deleteVerseMarkedOnTable);
    on<GetVersesMarkedOnTable>(_getVersesMarkedOnTable);
    on<GetIdVerseOnDatabase>(_getIdVerseOnDatabase);
  }
  final LocalDatabaseService _localService;

  Future<void> _changeColor(ChangeColor event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStats.success, pickerColor: event.color));
  }

  Future<void> _setIndexVerseClicked(
      SetIndexVerseClicked event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStats.loading));
    emit(state.copyWith(
        status: HomeStats.success, indexItemClicked: event.index));
  }

  Future<void> _setDefaultValuesBible(
      SetDefaultValuesBible event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStats.loading));
    emit(state.copyWith(
        status: HomeStats.success,
        bookSelected: event.bookModel,
        chapterSelected: event.chapterModel,
        verseSelected: event.verseModel,
        versesList: event.chapterModel.verses,scrollableListVerses: true));
  }

  Future<void> _configureVersesMarked(
      ConfigureVersesMarked event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStats.loading));
    var versesListAux = state.versesList;
    for (VersesMarkedModel marked in state.listMarkedModel) {
      if (marked.bookId == state.bookSelected.id &&
          marked.chapterId == state.chapterSelected.id) {
        for (VerseModel verses in versesListAux) {
          if (marked.verseId == verses.id) {
            verses.copyWith(isMarked: true);
            verses.copyWith(colorMarked: marked.colorMarked);
          }
        }
      }
    }
    emit(state.copyWith(status: HomeStats.success, versesList: versesListAux));
  }

  Future<void> _setVerseSelected(
      SetVerseSelected event, Emitter<HomeState> emit) async {
        emit(state.copyWith(status: HomeStats.loading));
    state.versesList[event.index] =
        state.versesList[event.index].copyWith(isMarked: true);
    emit(state.copyWith(status: HomeStats.success,versesList: state.versesList));
  }

  Future<void> _changeVerseMarkedStatus(
      ChangeVerseMarkedStatus event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStats.loading));
    var listAux = state.versesList;
    listAux[state.indexItemClicked].copyWith(
        colorMarked: state.pickerColor, isMarked: event.valueForMarked);

    emit(state.copyWith(status: HomeStats.success, versesList: listAux));
  }

  Future<void> _addVerseMarkedOnTable(
      AddVerseMarkedOnTable event, Emitter<HomeState> emit) async {
    if (state.verseIfExists.id == -1) {
      add(ChangeColor(color: event.color));
      add(const ChangeVerseMarkedStatus());
      VersesMarkedModel verseModelSelected = VersesMarkedModel(
          bookId: state.bookSelected.id,
          chapterId: state.chapterSelected.id,
          verseId: state.verseSelected.id,
          colorMarked: state.pickerColor);
      int idItemInserted = await _localService.insertValues(
          table: VersesMarkedTable.tableName,
          values: verseModelSelected.toMap());
    } else {
      add(ChangeColor(color: event.color));
      add(const ChangeVerseMarkedStatus());
      add(UpdateColorVerseMarked(model: state.verseIfExists));
    }
  }

  Future<void> _updateColorVerseMarked(
      UpdateColorVerseMarked event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStats.loading));
    await _localService.updateValue(
        table: VersesMarkedTable.tableName,
        values: event.model.toMap(),
        whereSentence: 'id = ?',
        whereArgs: [event.model.id.toString()]);
    emit(state.copyWith(status: HomeStats.success));
  }

  Future<void> _deleteVerseMarkedOnTable(
      DeleteVerseMarkedOnTable event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStats.loading));
    if (event.verseIfExists.id != -1) {
      await _localService.delete(
          table: VersesMarkedTable.tableName,
          whereSentence: '${VersesMarkedTable.id} = ? ',
          whereArgs: [state.verseIfExists.id.toString()]);
    }
    emit(state.copyWith(status: HomeStats.success));
  }

  Future<void> _getVersesMarkedOnTable(
      GetVersesMarkedOnTable event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStats.loading));
    List response =
        await _localService.getValues(table: VersesMarkedTable.tableName);
    var listMarkedModel =
        response.map((e) => VersesMarkedModel.fromMap(e)).toList();
    emit(state.copyWith(
        status: HomeStats.success, listMarkedModel: listMarkedModel));
  }

  Future<void> _getIdVerseOnDatabase(
      GetIdVerseOnDatabase event, Emitter<HomeState> emit) async {
    List<Map<String, Object?>> values = await _localService.getValues(
        table: VersesMarkedTable.tableName,
        whereSentence:
            '${VersesMarkedTable.bookId} = ?  AND ${VersesMarkedTable.chapterId} = ? AND ${VersesMarkedTable.verseId} = ? ',
        whereArgs: [
          state.bookSelected.id.toString(),
          state.chapterSelected.id.toString(),
          state.verseSelected.id.toString()
        ]);
    if (values.isNotEmpty) {
      VersesMarkedModel versesMarkedModel =
          VersesMarkedModel.fromMap(values.first);
      emit(state.copyWith(verseIfExists: versesMarkedModel));
    } else {
      emit(state.copyWith(verseIfExists: const VersesMarkedModel(id: -1)));
    }
  }
}
