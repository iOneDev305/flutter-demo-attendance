import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constant/colors.dart';
import '../utils/constant/fonts_style.dart';
import '../utils/utils.dart';

void showCustomBottomSheet(BuildContext context, {
  required String title,
  required Widget content,
  required VoidCallback onButtonPressed,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  double? height, // Optional height parameter
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: backgroundColor ?? Colors.white,
    elevation: elevation ?? 16.0,
    shape: shape ??
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
    isScrollControlled: true,
    // Ensure full width and height are controlled
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: height ??
              MediaQuery.of(context).size.height *
                  0.75, // Default to 75% screen height
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context, title),
              const SizedBox(height: 10),
              _buildContent(content),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildHeader(BuildContext context, String title) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDragHandle(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: bold,
                  fontFamily: appFont,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        _buildCloseButton(context),
      ],
    ),
  );
}

Widget _buildDragHandle() {
  return Center(
    child: Container(
      height: 4,
      width: 50,
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Primitives.grey5,
        borderRadius: BorderRadius.circular(2.5),
      ),
    ),
  );
}

Widget _buildCloseButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pop(); // Close the bottom sheet on tap
    },
    child: Container(
      height: 35,
      width: 35,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Primitives.white,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/ic_close.svg',
          width: 12,
          height: 12,
        ),
      ),
    ),
  );
}

Widget _buildContent(Widget content) {
  return Expanded(
    child: SingleChildScrollView(
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: double.infinity,
          child: content,
        ),
      ),
    ),
  );
}
