import 'package:flutter/material.dart';
import 'package:quick_scanner/features/favorite/presentation/sceens/favorite_screen.dart';
import 'package:quick_scanner/features/generator/presentation/screens/generator_screen.dart';
import 'package:quick_scanner/features/history/presentation/screens/history_screen.dart';
import 'package:quick_scanner/features/scanner/presentation/screens/scanner_screen.dart';
import 'package:quick_scanner/features/settings/presentation/screens/setting_screen.dart';

class MainNavBarScreen extends StatefulWidget {
  const MainNavBarScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  static const String name = "/dashboard";

  @override
  State<MainNavBarScreen> createState() => _MainNavBarScreenState();
}

class _MainNavBarScreenState extends State<MainNavBarScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _screens = const [
    GeneratorScreen(),
    ScannerScreen(),
    HistoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _screens[_selectedIndex],
      ),

      bottomNavigationBar: NavigationBar(
        height: 72,
        elevation: 8,
        selectedIndex: _selectedIndex,
        animationDuration: const Duration(milliseconds: 300),

        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),

        indicatorColor: Colors.transparent,

        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.qr_code_2_outlined),
            selectedIcon: Icon(Icons.qr_code_2_rounded),
            label: "Generate",
          ),

          NavigationDestination(
            icon: Icon(Icons.document_scanner_outlined),
            selectedIcon: Icon(Icons.document_scanner_rounded),
            label: "Scan",
          ),

          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: "History",
          ),

          NavigationDestination(
            icon: Icon(Icons.favorite_border_rounded),
            selectedIcon: Icon(Icons.favorite_rounded),
            label: "Favorite",
          ),

          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
