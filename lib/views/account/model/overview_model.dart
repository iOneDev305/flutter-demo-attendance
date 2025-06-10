class OverviewModel {
  final String leadingIcons;
  final String titleKey; // Store only the key, not the translated text.

  OverviewModel({
    required this.leadingIcons,
    required this.titleKey,
  });
}

// Define the overview list with translation keys instead of translated strings.
final List<OverviewModel> overviewList = [
  OverviewModel(leadingIcons: "ic_language", titleKey: "language"),
];
