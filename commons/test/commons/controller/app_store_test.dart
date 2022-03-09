import 'package:commons/commons/controller/app_store.dart';
import 'package:commons/commons/services/local_database_service.dart';
import 'package:commons_dependencies/main.dart';
import 'package:flutter_test/flutter_test.dart';

class LocalDatabaseServiceImplMock extends Mock
    implements LocalDatabaseService {}

Future main() async {
  LocalDatabaseServiceImplMock localDatabaseRepositoryImplMock =
      LocalDatabaseServiceImplMock();
  final appStore = AppStore(localService: localDatabaseRepositoryImplMock);

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });


  test('Create Tables', () async {
    final Database db = await openDatabase(inMemoryDatabasePath, version: 1,
        onConfigure: (Database db) async {
      await db.execute('PRAGMA foreign_keys=ON');
    });

    await db.close();
  });
}

// Future<void> createTables(Database _localService) async {
//   await _localService.createTable(
//       sql: ''' CREATE TABLE IF NOT EXISTS ${ConfigTable.tableName} (
//     ${ConfigTable.id} INTEGER PRIMARY KEY NOT NULL,
//     ${ConfigTable.versionBible} TEXT,
//     ${ConfigTable.fontSizeVerse} REAL,
//     ${ConfigTable.isDark} BOOLEAN
//     )''');
//   await _localService.createTable(
//       sql: ''' CREATE TABLE IF NOT EXISTS ${VersesMarkedTable.tableName} (
//     ${VersesMarkedTable.id} INTEGER PRIMARY KEY NOT NULL,
//     ${VersesMarkedTable.bookId} INTEGER NOT NULL,
//     ${VersesMarkedTable.colorMarked} INTEGER NOT NULL,
//     ${VersesMarkedTable.chapterId} INTEGER NOT NULL,
//     ${VersesMarkedTable.verseId} INTEGER NOT NULL
//      )''');
//   await _localService.createTable(sql: '''
//     CREATE TABLE IF NOT EXISTS ${AnnotationsVersesTable.tableName} (
//     ${AnnotationsVersesTable.id} INTEGER PRIMARY KEY NOT NULL,
//     ${AnnotationsVersesTable.annotationText} TEXT,
//     ${AnnotationsVersesTable.annotationAudio} TEXT,
//     ${AnnotationsVersesTable.fkVerseMarkedId} INTEGER,
//     FOREIGN KEY(${AnnotationsVersesTable.fkVerseMarkedId})
//     REFERENCES ${VersesMarkedTable.tableName}(${VersesMarkedTable.id})
//     ON DELETE CASCADE)
//     ''');
// }
