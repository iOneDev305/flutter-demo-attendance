import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'constant/enum_type.dart';
import 'helper.dart';

String get appFont => currentAppFont();
const String _imagePath = 'assets/images/';
const String _iconPath = 'assets/icons/';
const String _giftPath = 'assets/gift/';

String getImageUrl({required String path, ImageType type = ImageType.png}) {
  return '$_imagePath$path.${type.name}';
}

String getIconUrl({required String path, ImageType type = ImageType.png}) {
  return '$_iconPath$path.${type.name}';
}

String getGifUrl({required String path, ImageType type = ImageType.gif}) {
  return '$_giftPath$path.${type.name}';
}

extension ScreenSizeExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
}

class ResponsiveUtils {
  // Static method to get horizontal padding based on constraints
  static double getHorizontalPadding(BoxConstraints constraints) {
    if (kIsWeb) {
      return constraints.maxWidth > 1200
          ? 120.0
          : (constraints.maxWidth > 800 ? 80.0 : 20.0);
    }
    return 0.0; // For non-web platforms
  }
}