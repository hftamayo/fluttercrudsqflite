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

  static Future<int> createData(String title, String? desc) async {
    final db = await SQLHelper.db();

    final data = {'title': title, 'desc': desc};
    final id = await db.insert('data', data,
        ConflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SQLHelper.db();
    return db.query('data', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {}
}
