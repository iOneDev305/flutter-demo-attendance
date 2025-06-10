import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../services/language/localization_service.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/enum_type.dart';
import '../../../../utils/utils.dart';
import '../../model/language_model.dart';

class LanguageSheet extends StatelessWidget {
  final LocalizationService localizationService =
      Get.find<LocalizationService>();

  @override
  Widget build(BuildContext context) {
    String currentLanguageCode = localizationService.currentLocale;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Surface.light.color,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 22),
                itemCount: languageList.length,
                itemBuilder: (context, index) {
                  final data = languageList[index];
                  final isSelected =
                      currentLanguageCode ==
                      (data.languageItem == LanguageItem.english ? 'en' : 'km');
                  return GestureDetector(
                    onTap: () => _onItemTap(data.languageItem), // Pass the enum
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: _buildLanguageItems(
                          leadingIcons: data.leadingIcons,
                          trailingIcons:
                              isSelected ? 'ic_radio_check' : 'ic_radio_normal',
                          title: data.title.tr,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Handle item tap using enum
  void _onItemTap(LanguageItem languageItem) {
    switch (languageItem) {
      case LanguageItem.english:
        localizationService.changeLocale('en');
        break;
      case LanguageItem.khmer:
        localizationService.changeLocale('km');
        break;
    }
    Get.back(); // Close the language sheet
  }

  // Build language items
  Widget _buildLanguageItems({
    required String leadingIcons,
    required String title,
    required String trailingIcons,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      child: Row(
        children: [
          Image.asset(
            getImageUrl(path: leadingIcons, type: ImageType.png),
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                fontFamily: appFont,
                color: TextColor.darkGrey.color,
              ),
            ),
          ),
          SvgPicture.asset(
            getIconUrl(path: trailingIcons, type: ImageType.svg),
          ),
        ],
      ),
    );
  }
}
