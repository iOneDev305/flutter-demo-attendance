import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/fonts_style.dart';
import '../../../../utils/utils.dart';
import '../../../authentication/logout_user/controller/logout_user_controller.dart';

class LogoutSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final hasSoftNavigationBar = mediaQuery.padding.bottom > 0;

    return Column(
      children: [
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Surface.light.color,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48),
                        child: Text(
                          'logout_title'.tr,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: regular,
                              fontFamily: appFont,
                              color: TextColor.darkGrey.color),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        _buildLogoutButton(),
        SizedBox(height: hasSoftNavigationBar ? mediaQuery.padding.bottom : 10),
      ],
    );
  }

  Widget _buildLogoutButton() {
    final LogoutUserController controller = Get.put(LogoutUserController());
    return SizedBox(
      width: double.infinity,
      child: Obx(() => GestureDetector(
            onTap: controller.isLoading.value ? null : controller.logout,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: controller.isLoading.value
                    ? Primitives.red4 // Disabled color when loading
                    : Button.buttonRed.color, // Enabled color
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: controller.isLoading.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2.0,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "processing".tr,
                            style: TextStyle(
                              fontFamily: appFont,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: TextColor.light.color,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'confirm_logout'.tr,
                        style: TextStyle(
                          fontFamily: appFont,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: TextColor.light.color,
                        ),
                      ),
              ),
            ),
          )),
    );
  }
}
