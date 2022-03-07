import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseInstance {
  Future<Database>? _db;

  Future<Database> getDb() {
    _db ??= _initDb();
    return _db!;
  }
  Future<Database> _initDb() async {
    String path = await getDatabasesPath();
    final Database db = await openDatabase(join(path, 'bible_app'), version: 1,
        onConfigure: (Database db) async {
      await db.execute('PRAGMA foreign_keys=ON');
    });
    return db;
  }
}
