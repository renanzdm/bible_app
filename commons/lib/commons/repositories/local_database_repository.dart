import '../models/bible_model.dart';

abstract class LocalDatabaseRepository {
  Future<void> createDatabase({required String sql});

  Future<List<Map<String, Object?>>> getValues({ required String table,
    List<String>? columnsReturn,
    String? whereSentence,
    List<String>? whereArgs,});

  Future<BibleModel> fetchDataBibleVersionSelected(
      {required String versionBible});

  Future<int> insertValues(
      {required String table, required Map<String, Object?> values});

  Future<void> insertValuesCustomQuery(
      {required String sql,List<String>? args});

  Future<int> updateValue(
      {required String table,
      String? whereSentence,
      List<String>? whereArgs,
      required Map<String, Object?> values});

  Future<void> delete({required String table,
      String? whereSentence,
      List<String>? whereArgs});
}
