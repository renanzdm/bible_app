import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:commons/commons/models/book_model.dart';
import 'package:commons/commons/models/chapter_model.dart';
import 'package:commons/commons/models/verse_model.dart';
import 'package:commons/commons/services/local_database_service.dart';
import 'package:commons/commons/utils/tables_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/verses_marked_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required LocalDatabaseService localDatabaseService})
      : _localDatabaseService = localDatabaseService,
        super(const HomeState()) {
    on<SetCurrentBible>(_setCurrentBible);
    on<GetListVersesMarked>(_getListVersesMarked);
    on<ConfigureVersesMarked>(_configureVersesMarked);
    on<ActiveAnimateListView>(_activeAnimateListView);
    on<ActiveAnimationController>(_activeAnimationController);
    on<AddVerseOnTable>(_addVerseOnTable);
  }

  final LocalDatabaseService _localDatabaseService;

  Future<void> _setCurrentBible(
      SetCurrentBible event, Emitter<HomeState> emit) async {
    emit(state.copyWith(stats: HomeStats.loading));
    emit(state.copyWith(
        stats: HomeStats.success,
        bookCurrent: event.bookCurrent,
        chapterCurrent: event.chapterCurrent,
        verseCurrent: event.verseCurrent,
        versesList: event.chapterCurrent.verses));
  }

  Future<void> _getListVersesMarked(
      GetListVersesMarked event, Emitter<HomeState> emit) async {
    emit(state.copyWith(stats: HomeStats.loading));
    var response = await _localDatabaseService.getValues(
        table: VersesMarkedTable.tableName);
    List<VersesMarkedModel> verses =
        response.map((e) => VersesMarkedModel.fromMap(e)).toList();
    emit(state.copyWith(
        stats: HomeStats.success,
        versesMarked: verses,
        makeConfigurationVerses: true));
  }

  Future<void> _configureVersesMarked(
      ConfigureVersesMarked event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
        stats: HomeStats.loading, makeConfigurationVerses: false));
    for (var marked in state.versesMarked) {
      if (marked.chapterId == state.chapterCurrent.id &&
          marked.bookId == state.bookCurrent.id) {
        for (var verse in state.versesList) {
          if (verse.id == marked.verseId) {
            int index = state.versesList.indexOf(verse);
            state.versesList.removeAt(index);
            state.versesList.insert(
                index,
                VersesModel(
                    id: verse.id,
                    colorMarked: marked.colorMarked,
                    isMarked: true,
                    verse: verse.verse));
          }
        }
      }
    }

    emit(
        state.copyWith(stats: HomeStats.success, versesList: state.versesList));
  }

  Future<void> _activeAnimateListView(
      ActiveAnimateListView event, Emitter<HomeState> emit) async {
    emit(state.copyWith(stats: HomeStats.success, animateList: event.animate));
  }

  Future<void> _activeAnimationController(
      ActiveAnimationController event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
        stats: HomeStats.success, activeAnimationController: event.animate));
  }

  Future<void> _addVerseOnTable(
      AddVerseOnTable event, Emitter<HomeState> emit) async {
    VersesMarkedModel model = VersesMarkedModel(
        bookId: state.bookCurrent.id,
        chapterId: state.chapterCurrent.id,
        verseId: 4,
        colorMarked: Colors.blue);
    await _localDatabaseService.insertValues(
        table: VersesMarkedTable.tableName, values: model.toMap());
    emit(state.copyWith(stats: HomeStats.success));
  }
}
