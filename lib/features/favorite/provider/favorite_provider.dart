import 'package:flutter/material.dart';
import 'package:quick_scanner/features/favorite/data/favorite_repository.dart';
import 'package:quick_scanner/features/history/data/models/history_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final FavoriteRepository _repository = FavoriteRepository();

  List<HistoryModel> favorites = [];

  bool isLoading = false;

  Future<void> loadFavorites() async {
    isLoading = true;
    notifyListeners();

    favorites = await _repository.getFavorites();

    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    await loadFavorites();
  }
}
