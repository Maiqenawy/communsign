import 'package:flutter/material.dart';
import 'package:cominsign/core/app_lang.dart';
import '../widgets/gradient_background.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String selectedLanguage;
  final Function(bool) onThemeChanged;
  final Function(String) onLanguageChanged;
  final String Function(String) t;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onThemeChanged,
    required this.onLanguageChanged,
    required this.t,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool isDarkMode;
  late String selectedLanguage;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
    selectedLanguage = widget.selectedLanguage;
  }

  String t(String key) => widget.t(key);

  Color get textColor => isDarkMode ? Colors.white : Colors.black;

  // بدل withOpacity (deprecated)
  Color get iconBg => isDarkMode
      ? const Color.fromRGBO(255, 255, 255, 0.20)
      : const Color.fromRGBO(0, 0, 0, 0.08);

  Color get dividerColor => isDarkMode
      ? const Color.fromRGBO(255, 255, 255, 0.30)
      : const Color.fromRGBO(0, 0, 0, 0.30);

  @override
  Widget build(BuildContext context) {
    // ✅ أي تغيير في AppLang.notifier => الصفحة تعمل rebuild
    return ValueListenableBuilder<int>(
      valueListenable: AppLang.notifier,
      builder: (_, __, ___) {
        return Scaffold(
          body: GradientBackground(
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 40),
                    _buildUserProfile(),
                    const SizedBox(height: 40),
                    _buildDivider(),
                    const SizedBox(height: 40),
                    _buildPreferencesTitle(),
                    const SizedBox(height: 30),
                    _buildLanguageOption(),
                    const SizedBox(height: 30),
                    _buildDarkModeOption(),
                    const SizedBox(height: 30),
                    _buildEmergencyContactsOption(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ================= Header =================
  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.settings, color: textColor, size: 32),
        const SizedBox(width: 12),
        Text(
          t('settings'),
          style: TextStyle(
            color: textColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ================= Profile =================
  Widget _buildUserProfile() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey[300],
          backgroundImage: const AssetImage('images/SETTING.png'),
          onBackgroundImageError: (_, __) {},
          child: const Icon(Icons.person, size: 40),
        ),
        const SizedBox(width: 20),
        Text(
          t('user'),
          style: TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ================= Divider =================
  Widget _buildDivider() {
    return Container(
      height: 1,
      color: dividerColor,
    );
  }

  // ================= Title =================
  Widget _buildPreferencesTitle() {
    return Text(
      t('preferences'),
      style: TextStyle(
        color: textColor,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ================= Language =================
  Widget _buildLanguageOption() {
    return _buildSettingRow(
      icon: Icons.language,
      title: t('language'),
      trailing: GestureDetector(
        onTap: _showLanguageDialog,
        child: Text(
          selectedLanguage,
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
    );
  }

  // ================= Dark Mode =================
  Widget _buildDarkModeOption() {
    return _buildSettingRow(
      icon: Icons.dark_mode,
      title: t('dark_mode'),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (value) {
          setState(() => isDarkMode = value);
          widget.onThemeChanged(value);
        },
      ),
    );
  }

  // ================= Emergency =================
  Widget _buildEmergencyContactsOption() {
    return _buildSettingRow(
      icon: Icons.phone,
      title: t('emergency'),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: textColor,
        size: 18,
      ),
    );
  }

  // ================= Row =================
  Widget _buildSettingRow({
    required IconData icon,
    required String title,
    required Widget trailing,
  }) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: iconBg,
          child: Icon(icon, color: textColor),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
            ),
          ),
        ),
        trailing,
      ],
    );
  }

  // ================= Language Dialog =================
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t('language')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _languageItem('English'),
            _languageItem('العربية'),
          ],
        ),
      ),
    );
  }

  Widget _languageItem(String lang) {
    return ListTile(
      title: Text(lang),
      onTap: () async {
        // ✅ حملي JSON فورًا عشان الكلام يتغير لحظيًا
        await AppLang.load(lang);

        setState(() => selectedLanguage = lang);

        // ✅ خزن/حدث الحالة في main
        widget.onLanguageChanged(lang);

        Navigator.pop(context);
      },
    );
  }
}
