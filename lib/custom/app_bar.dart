import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ione_office_intern/extension/navigator_extensions.dart';

import '../utils/constant/colors.dart';
import '../utils/constant/enum_type.dart';
import '../utils/constant/fonts_style.dart';
import '../utils/utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leadingIcon;
  final List<Widget>? trailingIcons;
  final VoidCallback? onLeadingIconPressed;
  final VoidCallback? onTrailingIconPressed;
  final Color bgAppBarColor;
  final Color titleColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool hideLeadingIcon;

  // Default icon URL
  static const String _defaultIconPath = "arrow_left";

  // Default leading icon
  Widget get _defaultLeadingIcon => SvgPicture.asset(
        getIconUrl(path: _defaultIconPath, type: ImageType.svg),
        width: 24,
        height: 24,
        fit: BoxFit.cover,
      );

  // Constructor with default values
  const CustomAppBar({
    Key? key,
    this.title,
    this.leadingIcon,
    this.trailingIcons,
    this.onLeadingIconPressed,
    this.onTrailingIconPressed,
    this.bgAppBarColor = Primitives.bluePrimary,
    this.titleColor = Primitives.white,
    this.hideLeadingIcon = false,
    this.fontSize = 16,
    this.fontWeight = bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bool isWeb = kIsWeb; // Check if the app is running on the web
    final screenWidth = MediaQuery.of(context).size.width;
    // Determine horizontal padding based on screen width and platform
    final double horizontalPadding = isWeb
        ? (screenWidth > 1200 ? 120.0 : (screenWidth > 800 ? 80.0 : 20.0))
        : 0.0;

    return Stack(
      children: [
        Container(
          color: bgAppBarColor,
          height: kToolbarHeight,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: AppBar(
            backgroundColor: bgAppBarColor,
            surfaceTintColor: bgAppBarColor,
            centerTitle: true,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
            ),
            leading: !hideLeadingIcon
                ? (leadingIcon != null
                    ? IconButton(
                        icon: leadingIcon!,
                        onPressed: () {
                          if (onLeadingIconPressed != null) {
                            onLeadingIconPressed!();
                          } else {
                            context.pop();
                          }
                        },
                        splashColor:
                            Colors.transparent, // Disable splash effect
                        highlightColor:
                            Colors.transparent, // Disable highlight effect
                      )
                    : IconButton(
                        icon: _defaultLeadingIcon,
                        onPressed: () {
                          if (onLeadingIconPressed != null) {
                            onLeadingIconPressed!();
                          } else {
                            context.pop();
                          }
                        },
                        splashColor:
                            Colors.transparent, // Disable splash effect
                        highlightColor:
                            Colors.transparent, // Disable highlight effect
                      ))
                : null,
            title: title != null
                ? Text(
                    title!,
                    style: TextStyle(
                      fontFamily: appFont,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: titleColor,
                    ),
                  )
                : null,
            elevation: 0,
            actions: trailingIcons
                ?.map((icon) => Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      // Adjust spacing here
                      child: GestureDetector(
                        onTap: onTrailingIconPressed,
                        child: icon,
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
