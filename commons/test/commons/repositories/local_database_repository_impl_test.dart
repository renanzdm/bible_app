import 'package:commons/commons/models/config_model.dart';
import 'package:commons/commons/repositories/local_database_repository.dart';
import 'package:commons/commons/utils/tables_info.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter_test/flutter_test.dart';

class LocalDatabaseRepositoryImplMock extends Mock
    implements LocalDatabaseRepository {}

Future main() async {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  final localDatabaseRepositoryImplMock = LocalDatabaseRepositoryImplMock();

  test('Insert values', () async {
    final Database db = await openDatabase(inMemoryDatabasePath, version: 1,
        onConfigure: (Database db) async {
      await db.execute('PRAGMA foreign_keys=ON');
    });

    ConfigModel values = const ConfigModel(
        versionBible: 'teste', isDark: true, fontSizeVerse: 12, id: 0);
    when(() => localDatabaseRepositoryImplMock.insertValues(
        table: ConfigTable.tableName,
        values: values.toMap())).thenAnswer((_) async => 0);
    //retorna o id do valor inserido
    int lastRow = await localDatabaseRepositoryImplMock.insertValues(
        table: ConfigTable.tableName, values: values.toMap());
    expect(lastRow, 0);
  });
  test('Create Table', () async {
    final Database db = await openDatabase(inMemoryDatabasePath, version: 1,
        onConfigure: (Database db) async {
      await db.execute('PRAGMA foreign_keys=ON');
    });
    when(() =>
            localDatabaseRepositoryImplMock.createTable(sql: any(named: 'sql')))
        .thenAnswer((_) async {});
    await localDatabaseRepositoryImplMock.createTable(
        sql: ''' CREATE TABLE IF NOT EXISTS ${ConfigTable.tableName} (
    ${ConfigTable.id} INTEGER PRIMARY KEY NOT NULL,
    ${ConfigTable.versionBible} TEXT,
    ${ConfigTable.fontSizeVerse} REAL,
    ${ConfigTable.isDark} BOOLEAN
    )''');
    await db.close();
  });

  test('Get values', () async {
    final Database db = await openDatabase(inMemoryDatabasePath, version: 1,
        onConfigure: (Database db) async {
      await db.execute('PRAGMA foreign_keys=ON');
    });
    List<Map<String, Object?>> result = [
      {
        ConfigTable.id: 0,
        ConfigTable.fontSizeVerse: 12,
        ConfigTable.isDark: 1,
        ConfigTable.versionBible: 'pt_nvi'
      }
    ];
    when(() => localDatabaseRepositoryImplMock.getValues(
        table: ConfigTable.tableName)).thenAnswer((_) => Future.value(result));
    var res = await localDatabaseRepositoryImplMock.getValues(
        table: ConfigTable.tableName);
    expect(res, isA<List<Map<String, Object?>>>());
    expect(res[0]['id'], 0);

    await db.close();
  });

  test('Update value', () async {
    final Database db = await openDatabase(inMemoryDatabasePath, version: 1,
        onConfigure: (Database db) async {
      await db.execute('PRAGMA foreign_keys=ON');
    });
    ConfigModel values = const ConfigModel(
        versionBible: 'teste', isDark: true, fontSizeVerse: 12, id: 0);
    when(() => localDatabaseRepositoryImplMock.updateValue(
        table: ConfigTable.tableName,
        values: values.toMap())).thenAnswer((_) => Future.value(1));
    var res = await localDatabaseRepositoryImplMock.updateValue(
        table: ConfigTable.tableName, values: values.toMap());
    expect(res, isA<int>());
    expect(res, 1);

    await db.close();
  });

  test('Delete value', () async {
    final Database db = await openDatabase(inMemoryDatabasePath, version: 1,
        onConfigure: (Database db) async {
      await db.execute('PRAGMA foreign_keys=ON');
    });
    when(
      () => localDatabaseRepositoryImplMock.delete(
          table: ConfigTable.tableName,
          whereSentence: 'where id = ?',
          whereArgs: ['0']),
    ).thenAnswer((_) async => Future.value(1));
    int rowsAffected = await localDatabaseRepositoryImplMock.delete(
        table: ConfigTable.tableName,
        whereSentence: 'where id = ?',
        whereArgs: ['0']);

    expect(rowsAffected, 1);

    await db.close();
  });
}
