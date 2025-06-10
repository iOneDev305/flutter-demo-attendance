import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'language_controller.dart';

class LanguageSwitcher extends StatelessWidget {
  final LanguageController _languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        _languageController.changeLanguage(value);
      },
      itemBuilder: (BuildContext context) {
        return ['en', 'km'].map((String langCode) {
          return PopupMenuItem<String>(
            value: langCode,
            child: Text(_getLanguageName(langCode)),
          );
        }).toList();
      },
    );
  }

  String _getLanguageName(String langCode) {
    switch (langCode) {
      case 'km':
        return 'Khmer';
      case 'en':
      default:
        return 'English';
    }
  }
}
