import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/constant/enum_type.dart';
import '../utils/utils.dart';

extension ImageExtension on String {
  SvgPicture get toSVGIcon =>
      SvgPicture.asset(getIconUrl(path: this, type: ImageType.svg));

  Image get toPNGIcon =>
      Image.asset(getIconUrl(path: this, type: ImageType.png));

  SvgPicture get toSVGImage =>
      SvgPicture.asset(getImageUrl(path: this, type: ImageType.svg));

  Image get toPNGImage =>
      Image.asset(getImageUrl(path: this, type: ImageType.png));
}
