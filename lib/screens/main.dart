import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_links/app_links.dart';

import 'home.dart';
import 'setting.dart';
import 'splash_empty.dart';
import 'splash_logo.dart';
import 'login_screen.dart';
import 'hello_screen.dart';
import 'signUp.dart';
import 'forget_pass.dart';
import 'chat_with_us.dart';
import 'communication.dart';
import 'emergency.dart';
import 'learning.dart';
import 'Level_screen.dart';
import 'reset_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('dark_mode') ?? false;

  const language = 'English';

  runApp(MyApp(isDarkMode: isDark, language: language));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;
  final String language;

  const MyApp({super.key, required this.isDarkMode, required this.language});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late bool isDarkMode;
  late String selectedLanguage;

  late AppLinks _appLinks;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    isDarkMode = widget.isDarkMode;
    selectedLanguage = widget.language;

    /// Deep Link Setup
    _appLinks = AppLinks();

    _appLinks.uriLinkStream.listen((uri) {

      if (uri != null) {

        String? email = uri.queryParameters['email'];
        String? token = uri.queryParameters['token'];

        if (uri.host == "reset-password") {

          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (_) => ResetPasswordScreen(
                email: email!,
                token: token!,
              ),
            ),
          );

        }
      }

    });

  }

  Future<void> updateTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', value);
    setState(() => isDarkMode = value);
  }

  Future<void> updateLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang);
    setState(() => selectedLanguage = lang);
  }

  @override
  Widget build(BuildContext context) {

    final isArabic = selectedLanguage == 'العربية';

    return MaterialApp(

      navigatorKey: navigatorKey,

      debugShowCheckedModeBanner: false,

      builder: (context, child) => Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: child!,
      ),

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),

      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      initialRoute: '/',

      routes: {

        '/': (_) => const SplashEmptyScreen(),

        '/logo': (_) => const SplashLogoScreen(),

        '/login': (_) => const LoginScreen(),

        '/hello': (_) => const HelloScreen(),

        '/signUp': (_) => const SignUpScreen(),

        '/forget': (_) => const ForgetPass(),

        '/home': (_) => const HomeScreen(),

        '/chat': (_) => const ChatWithUs(),

        '/communication': (_) => const Communication(),

        '/emergency': (_) => const NewContactPage(),

        '/learning': (_) => const Learning(),

        '/level': (_) => const LevelScreen(),

        '/setting': (_) => SettingsScreen(
          isDarkMode: isDarkMode,
          selectedLanguage: selectedLanguage,
          onThemeChanged: updateTheme,
          onLanguageChanged: updateLanguage,
          t: (key) => key,
        ),
      },
    );
  }
}
