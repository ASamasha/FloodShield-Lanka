import 'package:flutter/material.dart';
import '../../features/profile/domain/repos/settings_repository.dart';

class SettingsController extends ChangeNotifier {
  final SettingsRepository repository;
  
  bool _darkMode = false;
  String _language = 'en';

  SettingsController({required this.repository});

  bool get darkMode => _darkMode;
  String get language => _language;
  ThemeMode get themeMode => _darkMode ? ThemeMode.dark : ThemeMode.light;
  Locale get locale => Locale(_language);

  Future<void> loadSettings() async {
    final settings = await repository.getSettings();
    _darkMode = settings.darkMode;
    _language = settings.language;
    notifyListeners();
  }

  Future<void> updateDarkMode(bool value) async {
    _darkMode = value;
    await repository.updateSetting('darkMode', value);
    notifyListeners();
  }

  Future<void> updateLanguage(String langCode) async {
    _language = langCode;
    await repository.updateSetting('language', langCode);
    notifyListeners();
  }
}
