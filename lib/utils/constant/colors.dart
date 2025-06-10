// Define your color primitives here
import 'dart:ui';

import 'package:flutter/material.dart';

class Primitives {
  // Blue Colors
  static const bluePrimary = Color(0xFF4FADF9);
  static const blue1 = Color(0xEFF7F5FF);
  static const blue2 = Color(0xFFE7F5FF);
  static const blue3 = Color(0xFFA5D8FF);
  static const blue4 = Color(0xFF74C0FC);
  static const blue5 = Color(0xFF4DABF7);
  static const blue6 = Color(0xFF339AF0);
  static const blue7 = Color(0xFF228BE6);
  static const blue8 = Color(0xFF1C7ED6);
  static const blue9 = Color(0xFF1971C2);
  static const blue10 = Color(0xFF1864AB);

  // Grey Colors
  static const grey1 = Color(0xFFF8F9FA);
  static const grey2 = Color(0xFFF1F3F5);
  static const grey3 = Color(0xFFE9ECEF);
  static const grey4 = Color(0xFFDEE2E6);
  static const grey5 = Color(0xFFCED4DA);
  static const grey6 = Color(0xFFADB5BD);
  static const grey7 = Color(0xFF868E96);
  static const grey8 = Color(0xFF495057);
  static const grey9 = Color(0xFF343A40);
  static const grey10 = Color(0xFF212529);

  // Green Colors
  static const green1 = Color(0xFFE6FCF5);
  static const green2 = Color(0xFFC3FAE8);
  static const green3 = Color(0xFF96F2D7);
  static const green4 = Color(0xFF63E6BE);
  static const green5 = Color(0xFF38D9A9);
  static const green6 = Color(0xFF20C997);
  static const green7 = Color(0xFF12B886);
  static const green8 = Color(0xFF0CA678);
  static const green9 = Color(0xFF099268);
  static const green10 = Color(0xFF087F5B);

  // Yellow Colors
  static const yellow1 = Color(0xFFFFF9DB);
  static const yellow2 = Color(0xFFFFF3BF);
  static const yellow3 = Color(0xFFFFEC99);
  static const yellow4 = Color(0xFFFFE066);
  static const yellow5 = Color(0xFFFFD43B);
  static const yellow6 = Color(0xFFFCC419);
  static const yellow7 = Color(0xFFFAB005);
  static const yellow8 = Color(0xFFF59F00);
  static const yellow9 = Color(0xFFF08C00);
  static const yellow10 = Color(0xFFE67700);

  // Red Colors
  static const red1 = Color(0xFFFFF5F5);
  static const red2 = Color(0xFFFFE3E3);
  static const red3 = Color(0xFFFFC9C9);
  static const red4 = Color(0xFFFFA8A8);
  static const red5 = Color(0xFFFF8787);
  static const red6 = Color(0xFFFF6B6B);
  static const red7 = Color(0xFFFA5252);
  static const red8 = Color(0xFFF03E3E);
  static const red9 = Color(0xFFE03131);
  static const red10 = Color(0xFFC92A2A);

  // Cyan Colors
  static const cyan1 = Color(0xFFE3FAFC);
  static const cyan2 = Color(0xFFC5F6FA);
  static const cyan3 = Color(0xFF99E9F2);
  static const cyan4 = Color(0xFF66D9E8);
  static const cyan5 = Color(0xFF3BC9DB);
  static const cyan6 = Color(0xFF22B8CF);
  static const cyan7 = Color(0xFF15AABF);
  static const cyan8 = Color(0xFF1098AD);
  static const cyan9 = Color(0xFF0C8599);
  static const cyan10 = Color(0xFF0B7285);

  // Grape Colors
  static const grape1 = Color(0xFFF8F0FC);
  static const grape2 = Color(0xFFF3D9FA);
  static const grape3 = Color(0xFFEEBEFA);
  static const grape4 = Color(0xFFE599F7);
  static const grape5 = Color(0xFFDA77F2);
  static const grape6 = Color(0xFFCC5DE8);
  static const grape7 = Color(0xFFBE4BDB);
  static const grape8 = Color(0xFFAE3EC9);
  static const grape9 = Color(0xFF9C36B5);
  static const grape10 = Color(0xFF862E9C);

  // White and Black
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF111111);
}

Color colorFromString(String colorString) {
  try {
    return Color(int.parse(colorString));
  } catch (e) {
    return Colors.black; // Default color in case of an error
  }
}

/* Tokens */

// Enum for different surfaces
enum Surface {
  surfaceBlue,
  darkBlue,
  lightBlue,
  grey,
  darkGrey,
  lightGrey,
  light,
  dark,
}

extension SurfaceExtension on Surface {
  // Get the corresponding color for each Surface enum value
  Color get color {
    switch (this) {
      case Surface.surfaceBlue:
        return Primitives.bluePrimary;
      case Surface.darkBlue:
        return Primitives.blue8;
      case Surface.lightBlue:
        return Primitives.blue2;
      case Surface.grey:
        return Primitives.grey5;
      case Surface.darkGrey:
        return Primitives.grey8;
      case Surface.lightGrey:
        return Primitives.grey1;
      case Surface.light:
        return Primitives.white;
      case Surface.dark:
        return Primitives.black;
    }
  }
}

// Enum for different TextColor
enum TextColor {
  textBlue,
  darkBlue,
  lightBlue,
  grey,
  darkGrey,
  lightGrey,
  green,
  darkGreen,
  lightGreen,
  yellow,
  darkYellow,
  lightYellow,
  red,
  darkRed,
  lightRed,
  cyan,
  darkCyan,
  lightCyan,
  grape,
  darkGrape,
  lightGrape,
  light,
  dark,
}

extension TextColorExtension on TextColor {
  // Get the corresponding color for each TextColor enum value
  Color get color {
    switch (this) {
      case TextColor.textBlue:
        return Primitives.bluePrimary;
      case TextColor.darkBlue:
        return Primitives.blue8;
      case TextColor.lightBlue:
        return Primitives.blue1;
      case TextColor.grey:
        return Primitives.grey7;
      case TextColor.darkGrey:
        return Primitives.grey8;
      case TextColor.lightGrey:
        return Primitives.grey6;
      case TextColor.green:
        return Primitives.green5;
      case TextColor.darkGreen:
        return Primitives.green8;
      case TextColor.lightGreen:
        return Primitives.green1;
      case TextColor.yellow:
        return Primitives.yellow5;
      case TextColor.darkYellow:
        return Primitives.yellow8;
      case TextColor.lightYellow:
        return Primitives.yellow1;
      case TextColor.red:
        return Primitives.red5;
      case TextColor.darkRed:
        return Primitives.red8;
      case TextColor.lightRed:
        return Primitives.red1;
      case TextColor.cyan:
        return Primitives.cyan5;
      case TextColor.darkCyan:
        return Primitives.cyan8;
      case TextColor.lightCyan:
        return Primitives.cyan1;
      case TextColor.grape:
        return Primitives.grape5;
      case TextColor.darkGrape:
        return Primitives.grape8;
      case TextColor.lightGrape:
        return Primitives.grape1;
      case TextColor.light:
        return Primitives.white;
      case TextColor.dark:
        return Primitives.black;
    }
  }
}

// Enum for different View colors
enum ViewColor {
  containerCyan,
  containerDarkCyan,
  containerLightCyan,
  containerGrape,
  containerDarkGrape,
  containerLightGrape,
  containerBlue,
  containerDarkBlue,
  containerLightBlue,
  containerGrey,
  containerDarkGrey,
  containerLightGrey,
  containerGreen,
  containerDarkGreen,
  containerLightGreen,
  containerYellow,
  containerDarkYellow,
  containerLightYellow,
  containerRed,
  containerDarkRed,
  containerLightRed,
  containerLight,
  containerDark,
}

extension ViewExtension on ViewColor {
  // Get the corresponding color for each View enum value
  Color get color {
    switch (this) {
      case ViewColor.containerCyan:
        return Primitives.cyan5;
      case ViewColor.containerDarkCyan:
        return Primitives.cyan8;
      case ViewColor.containerLightCyan:
        return Primitives.cyan1;
      case ViewColor.containerGrape:
        return Primitives.grape5;
      case ViewColor.containerDarkGrape:
        return Primitives.grape8;
      case ViewColor.containerLightGrape:
        return Primitives.grape1;
      case ViewColor.containerBlue:
        return Primitives.bluePrimary;
      case ViewColor.containerDarkBlue:
        return Primitives.blue8;
      case ViewColor.containerLightBlue:
        return Primitives.blue2;
      case ViewColor.containerGrey:
        return Primitives.grey5;
      case ViewColor.containerDarkGrey:
        return Primitives.grey8;
      case ViewColor.containerLightGrey:
        return Primitives.grey1;
      case ViewColor.containerGreen:
        return Primitives.green5;
      case ViewColor.containerDarkGreen:
        return Primitives.green8;
      case ViewColor.containerLightGreen:
        return Primitives.green2;
      case ViewColor.containerYellow:
        return Primitives.yellow5;
      case ViewColor.containerDarkYellow:
        return Primitives.yellow8;
      case ViewColor.containerLightYellow:
        return Primitives.yellow1;
      case ViewColor.containerRed:
        return Primitives.red5;
      case ViewColor.containerDarkRed:
        return Primitives.red8;
      case ViewColor.containerLightRed:
        return Primitives.red1;
      case ViewColor.containerLight:
        return Primitives.white;
      case ViewColor.containerDark:
        return Primitives.black;
    }
  }
}

// Enum for different Button colors
enum Button {
  buttonBlue,
  buttonDarkBlue,
  buttonLightBlue,
  buttonGrey,
  buttonDarkGrey,
  buttonLightGrey,
  buttonGreen,
  buttonDarkGreen,
  buttonLightGreen,
  buttonYellow,
  buttonDarkYellow,
  buttonLightYellow,
  buttonLightCyan,
  buttonCyan,
  buttonLightGrape,
  buttonGrape,
  buttonRed,
  buttonDarkRed,
  buttonLightRed,
  buttonLight,
  buttonDark,
  buttonDisable
}

extension ButtonExtension on Button {
  // Get the corresponding color for each Button enum value
  Color get color {
    switch (this) {
      case Button.buttonBlue:
        return Primitives.bluePrimary;
      case Button.buttonDarkBlue:
        return Primitives.blue8;
      case Button.buttonLightBlue:
        return Primitives.blue1;
      case Button.buttonDisable:
        return Primitives.blue3;
      case Button.buttonGrey:
        return Primitives.grey5;
      case Button.buttonDarkGrey:
        return Primitives.grey8;
      case Button.buttonLightGrey:
        return Primitives.grey1;
      case Button.buttonGreen:
        return Primitives.green5;
      case Button.buttonDarkGreen:
        return Primitives.green8;
      case Button.buttonLightGreen:
        return Primitives.green1;
      case Button.buttonYellow:
        return Primitives.yellow5;
      case Button.buttonDarkYellow:
        return Primitives.yellow8;
      case Button.buttonLightYellow:
        return Primitives.yellow1;
      case Button.buttonCyan:
        return Primitives.cyan5;
      case Button.buttonLightCyan:
        return Primitives.cyan1;
      case Button.buttonGrape:
        return Primitives.grape5;
      case Button.buttonLightGrape:
        return Primitives.grape1;
      case Button.buttonRed:
        return Primitives.red5;
      case Button.buttonDarkRed:
        return Primitives.red8;
      case Button.buttonLightRed:
        return Primitives.red1;
      case Button.buttonLight:
        return Primitives.white;
      case Button.buttonDark:
        return Primitives.black;
    }
  }
}

// Enum for different Border colors
enum Border {
  borderBlue,
  borderDarkBlue,
  borderLightBlue,
  borderGrey,
  borderDarkGrey,
  borderLightGrey,
  borderLight,
  borderDark
}

extension BorderExtension on Border {
  // Get the corresponding color for each Border enum value
  Color get color {
    switch (this) {
      case Border.borderBlue:
        return Primitives.bluePrimary;
      case Border.borderDarkBlue:
        return Primitives.blue8;
      case Border.borderLightBlue:
        return Primitives.blue2;
      case Border.borderGrey:
        return Primitives.grey5;
      case Border.borderDarkGrey:
        return Primitives.grey8;
      case Border.borderLightGrey:
        return Primitives.grey1;
      case Border.borderLight:
        return Primitives.white;
      case Border.borderDark:
        return Primitives.black;
    }
  }
}

// Enum for different Line colors
enum LineColor {
  lineBlue,
  lineDarkBlue,
  lineLightBlue,
  lineGrey,
  lineDarkGrey,
  lineLightGrey,
  lineRed,
  lineDarkRed,
  lineLightRed,
  lineLight,
  lineDark
}

extension LineExtension on LineColor {
  // Get the corresponding color for each Line enum value
  Color get color {
    switch (this) {
      case LineColor.lineBlue:
        return Primitives.bluePrimary;
      case LineColor.lineDarkBlue:
        return Primitives.blue8;
      case LineColor.lineLightBlue:
        return Primitives.blue2;
      case LineColor.lineGrey:
        return Primitives.grey2;
      case LineColor.lineDarkGrey:
        return Primitives.grey8;
      case LineColor.lineLightGrey:
        return Primitives.grey1;
      case LineColor.lineRed:
        return Primitives.red5;
      case LineColor.lineDarkRed:
        return Primitives.red8;
      case LineColor.lineLightRed:
        return Primitives.red1;
      case LineColor.lineLight:
        return Primitives.white;
      case LineColor.lineDark:
        return Primitives.black;
    }
  }
}

// Enum for different TextField colors
enum TextFieldColor {
  textFieldBlue,
  textFieldDarkBlue,
  textFieldLightBlue,
  textFieldGrey,
  textFieldDarkGrey,
  textFieldLightGrey,
  textFieldLight,
  textFieldDark
}

extension TextFieldExtension on TextFieldColor {
  // Get the corresponding color for each TextField enum value
  Color get color {
    switch (this) {
      case TextFieldColor.textFieldBlue:
        return Primitives.bluePrimary;
      case TextFieldColor.textFieldDarkBlue:
        return Primitives.blue8;
      case TextFieldColor.textFieldLightBlue:
        return Primitives.blue2;
      case TextFieldColor.textFieldGrey:
        return Primitives.grey2;
      case TextFieldColor.textFieldDarkGrey:
        return Primitives.grey8;
      case TextFieldColor.textFieldLightGrey:
        return Primitives.grey1;
      case TextFieldColor.textFieldLight:
        return Primitives.white;
      case TextFieldColor.textFieldDark:
        return Primitives.black;
    }
  }
}

// Enum for different Icon colors
enum IconsColors {
  iconDarkGreen,
  iconRed,
  iconGrey,
  iconDarkRed,
  iconDarkYellow,
  iconDarkGrey
}

extension IconsExtension on IconsColors {
  // Get the corresponding color for each Icons enum value
  Color get color {
    switch (this) {
      case IconsColors.iconDarkGreen:
        return Primitives.green8;
      case IconsColors.iconRed:
        return Primitives.red5;
      case IconsColors.iconGrey:
        return Primitives.grey6;
      case IconsColors.iconDarkRed:
        return Primitives.red8;
      case IconsColors.iconDarkYellow:
        return Primitives.yellow10;
      case IconsColors.iconDarkGrey:
        return Primitives.grey8;
    }
  }
}
