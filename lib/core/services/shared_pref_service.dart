import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String themeKey = 'theme_mode';

  Future<void> saveTheme(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeKey, value);
  }

  Future<String> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(themeKey) ?? 'system';
  }
}
