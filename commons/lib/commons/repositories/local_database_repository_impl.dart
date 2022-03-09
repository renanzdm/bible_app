import 'dart:convert';
import 'package:flutter/services.dart';

import '../local_database/local_database_instance.dart';
import '../models/bible_model.dart';
import 'local_database_repository.dart';

class LocalDatabaseRepositoryImpl implements LocalDatabaseRepository {
  final LocalDatabaseInstance _database;

  LocalDatabaseRepositoryImpl({required LocalDatabaseInstance database})
      : _database = database;

  @override
  Future<void> createTable({required String sql, List? arguments}) async {
    var _db = await _database.getDb();
    await _db.execute(sql, arguments);
  }

  @override
  Future<BibleModel> fetchDataBibleVersionSelected(
      {required String versionBible}) async {
    String data = await rootBundle.loadString('assets/json/$versionBible.json');
    var json = jsonDecode(data);
    return BibleModel.fromMap(json);
  }

  @override
  Future<int> insertValues(
      {required String table, required Map<String, Object?> values}) async {
    var _db = await _database.getDb();
   int  id = await _db.insert(table, values);
   return id;
  }

  @override
  Future<List<Map<String, Object?>>> getValues({
    required String table,
    List<String>? columnsReturn,
    String? whereSentence,
    List<String>? whereArgs,
  }) async {
    var _db = await _database.getDb();
    List<Map<String, Object?>> response = await _db.query(table,
        columns: columnsReturn, where: whereSentence, whereArgs: whereArgs);
    return response;
  }

  @override
  Future<int> updateValue(
      {required String table,
      String? whereSentence,
      List<String>? whereArgs,
      required Map<String, Object?> values}) async {
    var _db = await _database.getDb();
    return await _db.update(table, values,
        where: whereSentence, whereArgs: whereArgs);
  }

  @override
  Future<void> insertValuesCustomQuery(
      {required String sql, List<String>? args}) async {
    var _db = await _database.getDb();
    await _db.rawInsert(sql, args);
  }

  @override
  Future<int> delete(
      {required String table,
      String? whereSentence,
      List<String>? whereArgs}) async {
    var _db = await _database.getDb();
   int rowsAffected = await _db.delete(table, where: whereSentence, whereArgs: whereArgs);
   return rowsAffected;
  }
}
