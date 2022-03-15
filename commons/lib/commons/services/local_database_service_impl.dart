import '../models/bible_model.dart';
import '../repositories/local_database_repository.dart';
import 'local_database_service.dart';

class LocalDatabaseServiceImpl implements LocalDatabaseService {
  final LocalDatabaseRepository _localDatabaseRepository;

  LocalDatabaseServiceImpl(
      {required LocalDatabaseRepository localDatabaseRepository})
      : _localDatabaseRepository = localDatabaseRepository;

  @override
  Future<void> createTable({required String sql}) async =>
       _localDatabaseRepository.createTable(sql: sql);

  @override
  Future<BibleModel> configureDataBibleAllVersion(
          {required String versionBible}) async =>
       _localDatabaseRepository.fetchDataBibleVersionSelected(
          versionBible: versionBible);

  @override
  Future<int> insertValues(
          {required String table,
          required Map<String, Object?> values}) async =>
       _localDatabaseRepository.insertValues(table: table, values: values);

  @override
  Future<List<Map<String, Object?>>> getValues({
    required String table,
    List<String>? columnsReturn,
    String? whereSentence,
    List<String>? whereArgs,
  }) async =>
       _localDatabaseRepository.getValues(
        table: table,whereSentence: whereSentence,whereArgs: whereArgs
      );

  @override
  Future<int> updateValue(
          {required String table,
          String? whereSentence,
          List<String>? whereArgs,
          required Map<String, Object?> values}) async =>
      _localDatabaseRepository.updateValue(
          table: table,
          values: values,
          whereSentence: whereSentence,
          whereArgs: whereArgs);

  @override
  Future<void> insertValuesCustomQuery(
          {required String sql, List<String>? args}) async =>
       _localDatabaseRepository.insertValuesCustomQuery(
          sql: sql, args: args);

  @override
  Future<int> delete(
          {required String table,
          String? whereSentence,
          List<String>? whereArgs}) async =>
       _localDatabaseRepository.delete(
          table: table, whereSentence: whereSentence, whereArgs: whereArgs);

  @override
  Future<List<Map<String, Object?>>> getValuesCustomQuery(
          {required String sql, List<String>? args}) async =>
       _localDatabaseRepository.getValuesCustomQuery(sql: sql, args: args);
}
