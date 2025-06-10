import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constant/colors.dart';
import '../constant/enum_type.dart';
import '../constant/fonts_style.dart';
import '../utils.dart';

class RetryController extends GetxController {
  var isRetrying = false.obs;

  void retry() async {
    isRetrying.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isRetrying.value = false;
  }
}

class NoConnectionScreen extends StatelessWidget {
  final VoidCallback onRetry;
  final RetryController controller = Get.put(RetryController());

  NoConnectionScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Primitives.white,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 100),
              SvgPicture.asset(
                getIconUrl(path: 'ic_no_internet', type: ImageType.svg),
              ),
              const SizedBox(height: 40),
              Text(
                'no_internet'.tr,
                style: TextStyle(
                  fontSize: 20,
                  color: TextColor.dark.color,
                  fontFamily: appFont,
                  fontWeight: bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'something_is_wrong_with_your_connection'.tr,
                style: TextStyle(
                  fontSize: 14,
                  color: TextColor.grey.color,
                  fontFamily: appFont,
                  fontWeight: regular,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  controller.retry();
                  onRetry();
                },
                child: Obx(() {
                  return Container(
                    decoration: BoxDecoration(
                      color: Button.buttonBlue.color,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 47,
                    width: 166,
                    child: Center(
                      child: controller.isRetrying.value
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        TextColor.light.color),
                                    strokeWidth: 2.0,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Space between loader and text
                                Text(
                                  "processing".tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: TextColor.light.color,
                                    fontFamily: appFont,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              "click_try_again".tr,
                              style: TextStyle(
                                fontSize: 16,
                                color: TextColor.light.color,
                                fontFamily: appFont,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
