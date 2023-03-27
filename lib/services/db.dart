import 'package:sqflite/sqflite.dart' as sql;

class SQLService {
  static Future<void> createTables(sql.Database fluttertodo) async {
    await fluttertodo.execute("""CREATE TABLE tasks(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      desc TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("fluttertodo.db", version: 1,
        onCreate: (sql.Database fluttertodo, int version) async {
      await createTables(fluttertodo);
    });
  }
}
