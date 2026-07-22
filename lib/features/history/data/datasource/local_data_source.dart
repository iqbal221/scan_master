import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/history_model.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  static const String databaseName = "scanmaster.db";
  static const int databaseVersion = 1;

  static const String tableHistory = "history";

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), databaseName);

    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableHistory(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT NOT NULL,
        type TEXT NOT NULL,
        format TEXT NOT NULL,
        scannedAt TEXT NOT NULL,
        isFavorite INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  //--------------------------------------------------
  // Insert
  //--------------------------------------------------

  // Future<int> insertHistory(HistoryModel history) async {
  //   final db = await database;

  //   return await db.insert(
  //     tableHistory,
  //     history.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  Future<int> insertHistory(HistoryModel history) async {
    final db = await database;

    final id = await db.insert(tableHistory, history.toMap());

    print("Inserted ID: $id");

    return id;
  }

  //--------------------------------------------------
  // Get All
  //--------------------------------------------------

  Future<List<HistoryModel>> getHistory() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      tableHistory,
      orderBy: "id DESC",
    );

    return maps.map((e) => HistoryModel.fromMap(e)).toList();
  }

  //--------------------------------------------------
  // Search
  //--------------------------------------------------

  Future<List<HistoryModel>> searchHistory(String keyword) async {
    final db = await database;

    final maps = await db.query(
      tableHistory,
      where: "content LIKE ?",
      whereArgs: ["%$keyword%"],
      orderBy: "id DESC",
    );

    return maps.map((e) => HistoryModel.fromMap(e)).toList();
  }

  //--------------------------------------------------
  // Favorites
  //--------------------------------------------------

  Future<List<HistoryModel>> getFavorites() async {
    final db = await database;

    final maps = await db.query(
      tableHistory,
      where: "isFavorite = ?",
      whereArgs: [1],
      orderBy: "id DESC",
    );

    return maps.map((e) => HistoryModel.fromMap(e)).toList();
  }

  //--------------------------------------------------
  // Toggle Favorite
  //--------------------------------------------------

  Future<int> updateFavorite(int id, bool isFavorite) async {
    final db = await database;

    return await db.update(
      tableHistory,
      {"isFavorite": isFavorite ? 1 : 0},
      where: "id=?",
      whereArgs: [id],
    );
  }

  //--------------------------------------------------
  // Delete One
  //--------------------------------------------------

  Future<int> deleteHistory(int id) async {
    final db = await database;

    return await db.delete(tableHistory, where: "id=?", whereArgs: [id]);
  }

  //--------------------------------------------------
  // Delete All
  //--------------------------------------------------

  Future<int> deleteAllHistory() async {
    final db = await database;

    return await db.delete(tableHistory);
  }

  //--------------------------------------------------
  // Count
  //--------------------------------------------------

  Future<int> getTotalScans() async {
    final db = await database;

    final result = await db.rawQuery(
      "SELECT COUNT(*) as total FROM $tableHistory",
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  //--------------------------------------------------
  // Favorite Count
  //--------------------------------------------------

  Future<int> getFavoriteCount() async {
    final db = await database;

    final result = await db.rawQuery(
      "SELECT COUNT(*) as total FROM $tableHistory WHERE isFavorite=1",
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  //--------------------------------------------------
  // Close
  //--------------------------------------------------

  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
  }
}
