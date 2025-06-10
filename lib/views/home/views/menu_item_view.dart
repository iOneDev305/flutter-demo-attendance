import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/constant/enum_type.dart';
import '../../../utils/constant/fonts_style.dart';
import '../../../utils/utils.dart';

class MenuItem extends StatelessWidget {
  final String icon;
  final String text;

  const MenuItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Column(
        children: [
          _buildIcon(),
          const SizedBox(height: 12.5),
          _buildText(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Primitives.grey2,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Center(
        child: SvgPicture.asset(
          getIconUrl(path: icon, type: ImageType.svg),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: medium,
        color: TextColor.darkGrey.color,
      ),
      textAlign: TextAlign.center,
    );
  }
}
