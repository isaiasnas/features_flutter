import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<sql.Database> dataBase() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, int version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT, loc_lat REAL,loc_lng REAL, address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    var db = await DbHelper.dataBase();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    var db = await DbHelper.dataBase();
    return db.query(table);
  }
}
