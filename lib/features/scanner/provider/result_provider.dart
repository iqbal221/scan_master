import 'package:flutter/material.dart';
import 'package:quick_scanner/features/history/data/models/history_model.dart';
import 'package:quick_scanner/features/scanner/data/repository/result_repository.dart';
import 'package:quick_scanner/features/scanner/service/result_service.dart';

class ResultProvider extends ChangeNotifier {
  final ResultRepository _repository = ResultRepository();
  final ResultService _service = ResultService();

  bool isFavorite = false;
  bool isLoading = false;
  int? historyId;

  Future<void> copy(BuildContext context, String text) async {
    await _service.copyToClipboard(context, text);
  }

  Future<void> share(String text) async {
    await _service.share(text);
  }

  Future<void> open(String text) async {
    await _service.open(text);
  }

  Future<void> saveHistory({
    required String content,
    required String type,
    required String format,
    required DateTime scannedAt,
  }) async {
    print("saveHistory() called");
    final history = HistoryModel(
      content: content,
      type: type,
      format: format,
      scannedAt: scannedAt,
      isFavorite: false,
    );

    historyId = await _repository.saveHistory(history);
    print("History saved with ID: $historyId");

    notifyListeners();
  }

  Future<void> toggleFavorite(int id) async {
    isFavorite = !isFavorite;

    await _repository.toggleFavorite(id, isFavorite);

    notifyListeners();
  }

  Future<void> deleteHistory(int id) async {
    await _repository.deleteHistory(id);
  }

  bool canOpen(String value) {
    return _service.isUrl(value);
  }

  bool isPhone(String value) {
    return _service.isPhone(value);
  }

  bool isEmail(String value) {
    return _service.isEmail(value);
  }

  bool isWifi(String value) {
    return _service.isWifi(value);
  }

  bool isContact(String value) {
    return _service.isContact(value);
  }
}
