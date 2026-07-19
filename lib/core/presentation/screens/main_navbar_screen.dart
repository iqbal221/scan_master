import 'package:flutter/material.dart';
import 'package:quick_scanner/features/generator/presentation/screens/generator_screen.dart';
import 'package:quick_scanner/features/history/presentation/screens/history_screen.dart';
import 'package:quick_scanner/features/scanner/presentation/screens/scanner_screen.dart';

class MainNavBarScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavBarScreen({super.key, this.initialIndex = 0});

  static const String name = "/dashboard";

  @override
  State<MainNavBarScreen> createState() => _MainNavBarScreenState();
}

class _MainNavBarScreenState extends State<MainNavBarScreen> {
  int _selectedIndex = 0;

  final Color primaryColor = const Color(0xFF002DE3);

  final List<Widget> _screens = [
    const ScannerScreen(),
    const GeneratorScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,

        /// ⭐ SELECTED COLOR FIX
        // indicatorColor: AppTheme.lightTheme.primaryColor.withAlpha(10),
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        destinations: [
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            selectedIcon: Icon(
              Icons.qr_code_scanner,
              // color: AppTheme.lightTheme.primaryColor,
            ),
            label: "Scanner",
          ),

          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(
              Icons.qr_code_2,
              // color: AppTheme.lightTheme.primaryColor,
            ),
            label: "Generator",
          ),

          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(
              Icons.history,
              // color: AppTheme.lightTheme.primaryColor,
            ),
            label: "History",
          ),
        ],
      ),
    );
  }
}
