import 'package:quick_scanner/features/history/data/datasource/local_data_source.dart';

import '../models/history_model.dart';

class HistoryRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  static const String tableName = 'history';

  //==============================
  // Insert
  //==============================

  Future<int> insertHistory(HistoryModel history) async {
    final db = await _databaseHelper.database;

    return await db.insert(tableName, history.toMap());
  }

  //==============================
  // Get All
  //==============================

  Future<List<HistoryModel>> getAllHistory() async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: 'createdAt DESC',
    );

    return maps.map((e) => HistoryModel.fromMap(e)).toList();
  }

  //==============================
  // Get By ID
  //==============================

  Future<HistoryModel?> getHistoryById(int id) async {
    final db = await _databaseHelper.database;

    final maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return HistoryModel.fromMap(maps.first);
  }

  //==============================
  // Update
  //==============================

  Future<int> updateHistory(HistoryModel history) async {
    final db = await _databaseHelper.database;

    return await db.update(
      tableName,
      history.toMap(),
      where: 'id = ?',
      whereArgs: [history.id],
    );
  }

  //==============================
  // Toggle Favorite
  //==============================

  Future<void> toggleFavorite(HistoryModel history) async {
    final updated = history.copyWith(isFavorite: !history.isFavorite);

    await updateHistory(updated);
  }

  //==============================
  // Delete One
  //==============================

  Future<int> deleteHistory(int id) async {
    final db = await _databaseHelper.database;

    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  //==============================
  // Delete All
  //==============================

  Future<int> deleteAllHistory() async {
    final db = await _databaseHelper.database;

    return await db.delete(tableName);
  }

  //==============================
  // Search
  //==============================

  Future<List<HistoryModel>> searchHistory(String keyword) async {
    final db = await _databaseHelper.database;

    final maps = await db.query(
      tableName,
      where: 'content LIKE ? OR type LIKE ?',
      whereArgs: ['%$keyword%', '%$keyword%'],
      orderBy: 'createdAt DESC',
    );

    return maps.map((e) => HistoryModel.fromMap(e)).toList();
  }

  //==============================
  // Favorites
  //==============================

  Future<List<HistoryModel>> getFavorites() async {
    final db = await _databaseHelper.database;

    final maps = await db.query(
      tableName,
      where: 'isFavorite = ?',
      whereArgs: [1],
      orderBy: 'createdAt DESC',
    );

    return maps.map((e) => HistoryModel.fromMap(e)).toList();
  }

  //==============================
  // Count
  //==============================

  Future<int> count() async {
    final db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $tableName',
    );

    return result.first['count'] as int;
  }
}
