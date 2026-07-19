import 'package:flutter/material.dart';
import 'package:quick_scanner/app/app_routes.dart';
import 'package:quick_scanner/features/generator/presentation/screens/generator_screen.dart';
import 'package:quick_scanner/features/home/splash_screen.dart';

class ScanMaster extends StatefulWidget {
  const ScanMaster({super.key});

  @override
  State<ScanMaster> createState() => _ScanMasterState();
}

class _ScanMasterState extends State<ScanMaster> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: SplashScreen.name,
      onGenerateRoute: AppRoutes.routes,
      home: SplashScreen(),
    );
  }
}
