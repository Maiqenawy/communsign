import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  static String? token;
  static bool isGuest = false;

  // ✅ حفظ التوكن
  static Future<void> saveToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", value);
    token = value;
  }

  // ✅ تحميل التوكن
  static Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
  }import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  static String? token;
  static bool isGuest = false;

  // ✅ حفظ التوكن
  static Future<void> saveToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", value);
    token = value;
  }

  // ✅ تحميل التوكن
  static Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
  }
