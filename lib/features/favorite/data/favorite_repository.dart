import 'package:quick_scanner/features/history/data/datasource/local_data_source.dart';
import 'package:quick_scanner/features/history/data/models/history_model.dart';

class FavoriteRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;

  Future<List<HistoryModel>> getFavorites() async {
    final database = await _db.database;

    final result = await database.query(
      'history',
      where: 'isFavorite = ?',
      whereArgs: [1],
      orderBy: 'scannedAt DESC',
    );

    return result.map((e) => HistoryModel.fromMap(e)).toList();
  }
}
