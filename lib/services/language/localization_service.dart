import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService extends Translations {
  static const String _localeKey = 'locale';

  late String locale;

  @override
  Map<String, Map<String, String>> get keys => _localizedValues;

  Map<String, Map<String, String>> _localizedValues = {};

  Future<LocalizationService> init() async {
    final prefs = await SharedPreferences.getInstance();
    locale = prefs.getString(_localeKey) ?? 'en'; // Default to 'en'
    await _loadTranslations();
    return this;
  }

  Future<void> _loadTranslations() async {
    // Load your localization files
    final english =
        jsonDecode(await rootBundle.loadString('assets/lang/en.json'))
            as Map<String, dynamic>;
    final khmer = jsonDecode(await rootBundle.loadString('assets/lang/km.json'))
        as Map<String, dynamic>;
    _localizedValues = {
      'en': english.map((key, value) => MapEntry(key, value.toString())),
      'km': khmer.map((key, value) => MapEntry(key, value.toString())),
    };
  }

  // Getter to retrieve the current locale
  String get currentLocale => locale;

  String getFontFamily() {
    return currentLocale == 'km' ? 'KhmerOSBattambang' : 'OpenSans';
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    locale = prefs.getString(_localeKey) ?? 'en'; // Default to 'en'
  }

  void changeLocale(String newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    locale = newLocale;
    await prefs.setString(_localeKey, newLocale);
    Get.updateLocale(Locale(newLocale));
  }
}
