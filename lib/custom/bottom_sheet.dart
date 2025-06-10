import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/constant/colors.dart';
import '../utils/constant/enum_type.dart';
import '../utils/constant/fonts_style.dart';
import '../utils/utils.dart';

void customBottomSheet(
    BuildContext context, {
      String? title,
      Widget? content,
      Color? backgroundColor,
      double? elevation,
      ShapeBorder? shape,
      double? height,
      double? portraitHeight,
    }) {
  final screenHeight = MediaQuery.of(context).size.height;
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  final modalHeight = height ??
      (kIsWeb
          ? screenHeight * 0.6
          : isPortrait
          ? (portraitHeight ?? screenHeight * 0.5)
          : screenHeight);

  showModalBottomSheet(
    context: context,
    backgroundColor: backgroundColor ?? Primitives.grey2,
    elevation: elevation ?? 16.0,
    shape: shape ??
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
    isScrollControlled: true, // Allow full-height scrollable content
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
            ),
            child: SizedBox(
              height: modalHeight,
              child: Column(
                children: [
                  _buildTopContainer(context, title),
                  Expanded(child: content ?? Container()),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _buildTopContainer(BuildContext context, String? title) {
  return SizedBox(
    height: 64,
    width: double.infinity,
    child: Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 4,
                width: 45,
                color: Primitives.grey5,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: Text(
                  textAlign: TextAlign.center,
                  title ?? "",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: appFont,
                    fontWeight: bold,
                    color: TextColor.dark.color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Primitives.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  getIconUrl(path: 'ic_close', type: ImageType.svg),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
