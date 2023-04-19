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
    final db = await SQLService.db();

    final data = {'title': title, 'desc': desc};
    final id = await db.insert('tasks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SQLService.db();
    return db.query('tasks', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await SQLService.db();
    return db.query('tasks', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(int id, String title, String? desc) async {
    final db = await SQLService.db();
    final data = {
      'title': title,
      'desc': desc,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('tasks', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await SQLService.db();
    try {
      await db.delete('tasks', where: "id = ?", whereArgs: [id]);
    } catch (e) {}
  }
}
