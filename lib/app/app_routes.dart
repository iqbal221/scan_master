import 'package:flutter/material.dart';
import 'package:quick_scanner/features/generator/presentation/screens/generator_screen.dart';
import 'package:quick_scanner/features/home/splash_screen.dart';
import 'package:quick_scanner/features/scanner/presentation/screens/result_screen.dart';
import 'package:quick_scanner/features/scanner/presentation/screens/scanner_screen.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    Widget widget = SizedBox();

    if (settings.name == GeneratorScreen.name) {
      widget = GeneratorScreen();
    } else if (settings.name == SplashScreen.name) {
      widget = SplashScreen();
    } else if (settings.name == ScannerScreen.name) {
      widget = ScannerScreen();
    } else if (settings.name == ScanResultScreen.name) {
      final args = settings.arguments as Map<String, dynamic>;

      widget = ScanResultScreen(
        content: args['content'],
        type: args['type'],
        format: args['format'],
        scannedAt: args['scannedAt'],
      );

      // } else if (settings.name == MainNavBarScreen.name) {
      //   widget = MainNavBarScreen(initialIndex: 1);
      // } else if (settings.name == UpdateUserProfileScreen.name) {
      //   widget = UpdateUserProfileScreen();
      // } else if (settings.name == ContactScreen.name) {
      //   widget = ContactScreen();
      // } else if (settings.name == AddNewContactScreen.name) {
      //   widget = AddNewContactScreen();
      // } else if (settings.name == RegisterScreen.name) {
      //   widget = RegisterScreen();
      // } else if (settings.name == LoginScreen.name) {
      //   widget = LoginScreen();
      // } else if (settings.name == ChatScreen.name) {
      //   final args = settings.arguments as Map?;
      //   widget = ChatScreen(
      //     receiverId: args?['receiverId'] ?? '',
      //     receiverName: args?['receiverName'] ?? '',
      //     receiverImage: args?['receiverImage'] ?? '',
      //   );
      // } else if (settings.name == RecentChatScreen.name) {
      //   widget = RecentChatScreen();
      // }
    }

    return MaterialPageRoute(builder: (ctx) => widget);
  }
}
