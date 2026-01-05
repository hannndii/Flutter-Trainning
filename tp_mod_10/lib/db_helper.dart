import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  // Open database
  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tp_modul_10.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        await createTable(database);
      },
    );
  }

  // Create table
  static Future<void> createTable(Database database) async {
    await database.execute("""
      CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);
  }

  static Future<int> addItem(String title, String description) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': description,
    };

    final id = await db.insert(
      'items',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> readItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id DESC");
  }

  static Future<List<Map<String, dynamic>>> readItem(int id) async {
    final db = await SQLHelper.db();
    return db.query(
      'items',
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );
  }

  static Future<int> updateItem(
      int id, String title, String description) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': description,
      'createdAt': DateTime.now().toString(),
    };

    final result = await db.update(
      'items',
      data,
      where: "id = ?",
      whereArgs: [id],
    );

    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();

    await db.delete(
      'items',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
