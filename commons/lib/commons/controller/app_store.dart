
import 'package:mobx/mobx.dart';
import '../models/bible_model.dart';
import '../models/config_model.dart';
import '../models/verses_marked_model.dart';
import '../models/version_model.dart';
import '../services/local_database_service.dart';
import '../utils/tables_info.dart';




part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  _AppStore({
    required LocalDatabaseService localService,
  }) : _localService = localService;
  final LocalDatabaseService _localService;

  @observable
  ConfigModel config = const ConfigModel();
  @observable
  BibleModel bibleModel = BibleModel();
  List<VersionsModel> versionsBible = <VersionsModel>[];
  List<VersesMarkedModel> listMarkedModel = <VersesMarkedModel>[];

  @action
  Future<void> updateConfigTable() async {
    await _localService.updateValue(
        table: ConfigTable.tableName, values: config.toMap());
  }


  Future<void> changeVersionBible(VersionsModel versionsModel) async {
    config =
        config.copyWith(versionBible: versionsModel.value);
    await updateConfigTable();
  }

  Future<void> createTables() async {
    await _localService.createTable(
        sql: ''' CREATE TABLE IF NOT EXISTS ${ConfigTable.tableName} (
    ${ConfigTable.id} INTEGER PRIMARY KEY NOT NULL, 
    ${ConfigTable.versionBible} TEXT, 
    ${ConfigTable.fontSizeVerse} REAL, 
    ${ConfigTable.isDark} BOOLEAN
    )''');
    await _localService.createTable(
        sql: ''' CREATE TABLE IF NOT EXISTS ${VersesMarkedTable.tableName} (
    ${VersesMarkedTable.id} INTEGER PRIMARY KEY NOT NULL, 
    ${VersesMarkedTable.bookId} INTEGER NOT NULL, 
    ${VersesMarkedTable.colorMarked} INTEGER NOT NULL,
    ${VersesMarkedTable.chapterId} INTEGER NOT NULL, 
    ${VersesMarkedTable.verseId} INTEGER NOT NULL
     )''');
    await _localService.createTable(sql: '''
    CREATE TABLE IF NOT EXISTS ${AnnotationsVersesTable.tableName} ( 
    ${AnnotationsVersesTable.id} INTEGER PRIMARY KEY NOT NULL,
    ${AnnotationsVersesTable.annotationText} TEXT, 
    ${AnnotationsVersesTable.annotationAudio} TEXT, 
    ${AnnotationsVersesTable.fkVerseMarkedId} INTEGER,
    FOREIGN KEY(${AnnotationsVersesTable.fkVerseMarkedId}) 
    REFERENCES ${VersesMarkedTable.tableName}(${VersesMarkedTable.id}) 
    ON DELETE CASCADE)
    ''');
  }

  Future<void> insertConfigTable({ConfigModel? model}) async {
    model ??= const ConfigModel();
    await _localService.insertValues(
        table: ConfigTable.tableName, values: model.toMap());
  }

  Future<List<ConfigModel>> getConfigModel() async {
    var response = await _localService.getValues(table: ConfigTable.tableName);
    return response.map((e) => ConfigModel.fromMap(e)).toList();
  }

  Future<void> insertValueDefaultOnConfigTable() async {
    var response = await getConfigModel();
    if (response.isEmpty) await insertConfigTable();
    if (response.isNotEmpty) config = response.first;
  }

  Future<void> configureVersionsBible() async {
    bibleModel = await getBibleOfLocalJson();
  }

  Future<BibleModel> getBibleOfLocalJson() async {
    return await _localService.configureDataBibleAllVersion(
        versionBible: config.versionBible);
  }
}

// await _localService.insertValuesCustomQuery(
//       sql:
//           '''INSERT INTO ${VersesMarkedTable.tableName} (${VersesMarkedTable.bookId},
//           ${VersesMarkedTable.chapterId}, ${VersesMarkedTable.verseId}, ${VersesMarkedTable.colorMarked})
//   SELECT ${versesMarkedModel.bookId},${versesMarkedModel.chapterId}, ${versesMarkedModel.verseId},
//   ${versesMarkedModel.colorMarked.value}
//   WHERE NOT EXISTS(
//       SELECT 1
//       FROM ${VersesMarkedTable.tableName} WHERE ${VersesMarkedTable.bookId} = ${versesMarkedModel.bookId} AND
//       ${VersesMarkedTable.chapterId} =${versesMarkedModel.chapterId} AND
//       ${VersesMarkedTable.verseId} = ${versesMarkedModel.verseId}
//   )
//   ''');
