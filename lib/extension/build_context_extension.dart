import 'package:flutter/cupertino.dart';

extension ScreenSizeExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;
}
