
import '../models/bible_model.dart';

abstract class LocalDatabaseService{
  Future<void> createTable({required String sql});
  Future<BibleModel> configureDataBibleAllVersion({required String versionBible});
  Future<int> insertValues({required String table,required Map<String,Object?> values});
  Future<List<Map<String,Object?>>> getValues({ required String table,
    List<String>? columnsReturn,
    String? whereSentence,
    List<String>? whereArgs,});
  Future<int> updateValue(
      {required String table,
        String? whereSentence,
        List<String>? whereArgs,
        required Map<String, Object?> values});
  Future<void> insertValuesCustomQuery(
      {required String sql,List<String>? args});
Future<void> delete({required String table,
      String? whereSentence,
      List<String>? whereArgs});




}