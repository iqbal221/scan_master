import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_scanner/features/favorite/provider/favorite_provider.dart';
import 'package:quick_scanner/features/favorite/widgets/empty_favorite.dart';
import 'package:quick_scanner/features/favorite/widgets/favorite_tile.dart';

class FavoriteScreen extends StatefulWidget {
  static const name = "/favorite";

  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<FavoriteProvider>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FavoriteProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.favorites.isEmpty
          ? const EmptyFavorite()
          : RefreshIndicator(
              onRefresh: provider.refresh,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: provider.favorites.length,
                itemBuilder: (_, index) {
                  return FavoriteTile(history: provider.favorites[index]);
                },
              ),
            ),
    );
  }
}
