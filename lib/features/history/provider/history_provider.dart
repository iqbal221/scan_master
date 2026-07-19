import 'package:flutter/material.dart';
import 'package:quick_scanner/features/history/data/repository/history_repository.dart';
import '../data/models/history_model.dart';

class HistoryProvider extends ChangeNotifier {
  final HistoryRepository _repository = HistoryRepository();

  List<HistoryModel> _history = [];

  List<HistoryModel> get history => _history;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  //==============================
  // Load History
  //==============================

  Future<void> loadHistory() async {
    _isLoading = true;
    notifyListeners();

    _history = await _repository.getAllHistory();

    _sortNewest();

    _isLoading = false;

    notifyListeners();
  }

  //==============================
  // Add Scan
  //==============================

  Future<void> addHistory(HistoryModel history) async {
    await _repository.insertHistory(history);

    await loadHistory();
  }

  //==============================
  // Delete Item
  //==============================

  Future<void> deleteHistory(int id) async {
    await _repository.deleteHistory(id);

    await loadHistory();
  }

  //==============================
  // Delete All
  //==============================

  Future<void> deleteAllHistory() async {
    await _repository.deleteAllHistory();

    _history.clear();

    notifyListeners();
  }

  //==============================
  // Favorite
  //==============================

  Future<void> toggleFavorite(HistoryModel item) async {
    final updated = item.copyWith(isFavorite: !item.isFavorite);

    await _repository.updateHistory(updated);

    await loadHistory();
  }

  //==============================
  // Search
  //==============================

  void search(String keyword) {
    _searchQuery = keyword;

    notifyListeners();
  }

  List<HistoryModel> get filteredHistory {
    if (_searchQuery.isEmpty) {
      return _history;
    }

    return _history.where((item) {
      return item.content.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.type.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  //==============================
  // Sort
  //==============================

  void sortNewest() {
    _sortNewest();

    notifyListeners();
  }

  void sortOldest() {
    _history.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    notifyListeners();
  }

  void sortFavorites() {
    _history = _history.where((item) => item.isFavorite).toList();

    notifyListeners();
  }

  void _sortNewest() {
    _history.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  //==============================
  // Refresh
  //==============================

  Future<void> refresh() async {
    await loadHistory();
  }
}
