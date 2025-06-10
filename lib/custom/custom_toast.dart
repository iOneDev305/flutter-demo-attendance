import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constant/colors.dart';

enum Status { success, fail, underway, warning, general }

void showCustomToast({
  required String message,
  required Status status,
  VoidCallback? onDismiss,
}) {
  // Determine appearance based on Status
  final BuildContext context = Get.overlayContext!;
  Color backgroundFillColor;
  Color textColor;
  Widget leftIcon;
  Color rightIconColor;

  switch (status) {
    case Status.success:
      backgroundFillColor = ViewColor.containerLightGreen.color;
      textColor = TextColor.darkGreen.color;
      leftIcon = Icon(Icons.check, color: IconsColors.iconDarkGreen.color);
      rightIconColor = TextColor.darkGreen.color;
      break;
    case Status.fail:
      backgroundFillColor = ViewColor.containerLightRed.color;
      textColor = TextColor.darkRed.color;
      leftIcon = Icon(Icons.error, color: IconsColors.iconDarkRed.color);
      rightIconColor = TextColor.darkRed.color;
      break;
    case Status.underway:
      backgroundFillColor = ViewColor.containerLightGrey.color;
      textColor = TextColor.darkGrey.color;
      leftIcon =
          Icon(Icons.hourglass_empty, color: IconsColors.iconDarkGrey.color);
      rightIconColor = TextColor.darkGrey.color;
      break;
    case Status.warning:
      backgroundFillColor = ViewColor.containerLightYellow.color;
      textColor = TextColor.darkYellow.color;
      leftIcon = Icon(Icons.warning, color: IconsColors.iconDarkYellow.color);
      rightIconColor = TextColor.darkYellow.color;
      break;
    case Status.general:
      backgroundFillColor = ViewColor.containerLightGrey.color;
      textColor = TextColor.darkGrey.color;
      leftIcon = Icon(Icons.info, color: IconsColors.iconDarkGrey.color);
      rightIconColor = TextColor.darkGrey.color;
      break;
  }

  // Create a Completer to manage the toast's removal
  Completer<void> completer = Completer<void>();

  final overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        bottom: 50, // Adjust as needed
        left: 32,
        right: 32,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundFillColor,
              borderRadius: BorderRadius.circular(26),
            ),
            height: 48,
            child: Row(
              children: [
                SizedBox(width: 22),
                leftIcon,
                SizedBox(width: 11),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(color: textColor),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: rightIconColor),
                  onPressed: () {
                    if (!completer.isCompleted) {
                      completer.complete(); // Complete the completer
                    }
                  },
                ),
                SizedBox(width: 11),
              ],
            ),
          ),
        ),
      );
    },
  );

  // Function to remove the toast
  void removeToast() {
    if (overlayEntry.mounted) {
      overlayEntry.remove(); // Remove the toast
      if (onDismiss != null) {
        onDismiss(); // Call the optional onDismiss callback
      }
    }
  }

  // Insert the overlay entry
  final overlay = Overlay.of(context);
  overlay.insert(overlayEntry);

  // Set up a timer to auto-dismiss after 2 seconds
  Timer(Duration(seconds: 2), () {
    if (!completer.isCompleted) {
      completer.complete(); // Complete the completer
    }
  });

  // Wait for the completer to be completed and then remove the toast
  completer.future.whenComplete(removeToast);
}
