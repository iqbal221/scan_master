import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_scanner/app/app_routes.dart';
import 'package:quick_scanner/features/generator/presentation/screens/generator_screen.dart';
import 'package:quick_scanner/features/generator/provider/generator_provider.dart';
import 'package:quick_scanner/features/history/provider/history_provider.dart';
import 'package:quick_scanner/features/home/splash_screen.dart';
import 'package:quick_scanner/features/scanner/provider/scanner_provider.dart';

class ScanMaster extends StatefulWidget {
  const ScanMaster({super.key});

  @override
  State<ScanMaster> createState() => _ScanMasterState();
}

class _ScanMasterState extends State<ScanMaster> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeneratorProvider()),
        ChangeNotifierProvider(create: (_) => ScannerProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: SplashScreen.name,
        onGenerateRoute: AppRoutes.routes,
        home: SplashScreen(),
      ),
    );
  }
}
