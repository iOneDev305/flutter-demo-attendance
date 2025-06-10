// Define LanguageItem enum
import '../../../utils/constant/enum_type.dart';

class LanguageModel {
  final String leadingIcons;
  final String title;
  final LanguageItem languageItem; // Link enum to model

  LanguageModel({
    required this.leadingIcons,
    required this.title,
    required this.languageItem,
  });
}

// List of available languages
final List<LanguageModel> languageList = [
  LanguageModel(
      leadingIcons: "ic_khmer_flag",
      title: "khmer",
      languageItem: LanguageItem.khmer),
  LanguageModel(
      leadingIcons: "ic_english_flag",
      title: "english",
      languageItem: LanguageItem.english),

];
