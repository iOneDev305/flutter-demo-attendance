import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/constant/colors.dart';
import '../utils/constant/enum_type.dart';
import '../utils/constant/fonts_style.dart';
import '../utils/utils.dart';

void showRouteNameDialog(BuildContext context) {
  // Set up the buttons
  // Set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    content: Container(
      height: 100,
      color: Colors.white,
      child: Center(
          child: Text(
        "coming_soon".tr,
        style: TextStyle(
            fontFamily: appFont,
            fontSize: 18,
            fontWeight: medium,
            color: TextColor.darkGrey.color),
      )),
    ),
  );

  // Show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// The showLoadingDialog function remains unchanged
void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    // Prevent dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return const Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 6,
            color: Primitives.bluePrimary,
            backgroundColor: Primitives.grey5,
            strokeCap: StrokeCap.round,
          ),
        ),
      );
    },
  );
}

void showConfirmationDialog({
  required BuildContext context,
  required String message,
  required VoidCallback onConfirmed,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Primitives.grey3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SizedBox(
          height: 236,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                    getIconUrl(path: "ic_help_dialog", type: ImageType.svg)),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: bold,
                      fontFamily: appFont,
                      color: TextColor.darkGrey.color),
                ),
                const SizedBox(height: 24),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3.2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ViewColor.containerGrey.color,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(
                                  "no".tr,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: semiBold,
                                      fontFamily: appFont,
                                      color: TextColor.darkGrey.color),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3.2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(); // Close the dialog
                            onConfirmed();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ViewColor.containerBlue.color,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(
                                  "yes".tr,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: semiBold,
                                      fontFamily: appFont,
                                      color: TextColor.light.color),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showButtonOkayDialog({
  required BuildContext context,
  required String title,
  String subtitle = "", // Subtitle is now optional
  required String path,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Primitives.grey3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                getIconUrl(path: path, type: ImageType.svg),
                width: 60,
                height: 60,
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: bold,
                      fontFamily: appFont,
                      color: TextColor.darkGrey.color,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    // Only show subtitle if it's not empty
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: regular,
                        fontFamily: appFont,
                        color: TextColor.darkGrey.color,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ViewColor.containerBlue.color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        "okay".tr,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: semiBold,
                          fontFamily: appFont,
                          color: TextColor.light.color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
