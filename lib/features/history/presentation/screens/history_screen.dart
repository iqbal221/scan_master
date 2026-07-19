import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_scanner/features/history/widgets/delete_history_dialog.dart';
import 'package:quick_scanner/features/history/widgets/empty_history.dart';
import 'package:quick_scanner/features/history/widgets/history_search.dart';
import 'package:quick_scanner/features/history/widgets/history_title.dart';

import '../../provider/history_provider.dart';

class HistoryScreen extends StatefulWidget {
  static const String name = '/history';

  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HistoryProvider>().loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (_, provider, __) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Scan History"),
            centerTitle: true,
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) async {
                  switch (value) {
                    case 'Newest':
                      provider.sortNewest();
                      break;

                    case 'Oldest':
                      provider.sortOldest();
                      break;

                    case 'Favorites':
                      provider.sortFavorites();
                      break;

                    case 'Delete All':
                      final delete = await showDialog<bool>(
                        context: context,
                        builder: (_) => const DeleteHistoryDialog(),
                      );

                      if (delete == true) {
                        provider.deleteAllHistory();
                      }

                      break;
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'Newest', child: Text('Newest')),
                  PopupMenuItem(value: 'Oldest', child: Text('Oldest')),
                  PopupMenuItem(value: 'Favorites', child: Text('Favorites')),
                  PopupMenuDivider(),
                  PopupMenuItem(value: 'Delete All', child: Text('Delete All')),
                ],
              ),
            ],
          ),

          body: Column(
            children: [
              HistorySearchBar(onChanged: provider.search),

              Expanded(
                child: provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.filteredHistory.isEmpty
                    ? const EmptyHistory()
                    : RefreshIndicator(
                        onRefresh: provider.refresh,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          itemCount: provider.filteredHistory.length,
                          itemBuilder: (_, index) {
                            final item = provider.filteredHistory[index];

                            return Dismissible(
                              key: ValueKey(item.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                color: Colors.red,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (_) {
                                provider.deleteHistory(item.id!);
                              },
                              child: HistoryTile(history: item),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
