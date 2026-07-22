import 'package:quick_scanner/features/history/data/datasource/local_data_source.dart';
import 'package:quick_scanner/features/history/data/models/history_model.dart';

class ResultRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> saveHistory(HistoryModel history) async {
    return _databaseHelper.insertHistory(history);
  }

  Future<int> toggleFavorite(int id, bool isFavorite) async {
    return _databaseHelper.updateFavorite(id, isFavorite);
  }

  Future<int> deleteHistory(int id) async {
    return _databaseHelper.deleteHistory(id);
  }
}
