import 'package:get/get.dart';

import 'localization_service.dart';

class LanguageController extends GetxController {
  final LocalizationService _localizationService;

  LanguageController(this._localizationService);

  void changeLanguage(String langCode) {
    _localizationService.changeLocale(langCode);
  }
}
