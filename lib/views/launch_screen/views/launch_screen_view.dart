import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constant/colors.dart';
import '../../../utils/constant/enum_type.dart';
import '../../../utils/utils.dart';
import '../controller/launch_screen_controller.dart';

class LaunchScreenView extends StatelessWidget {
  const LaunchScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final LaunchScreenController controller = Get.put(LaunchScreenController());

    return Scaffold(
      backgroundColor: Primitives.bluePrimary,
      body: Obx(() {
        return _buildBody(controller, context);
      }),
    );
  }

  Widget _buildBody(LaunchScreenController controller, BuildContext context) {
    if (controller.isLoading.value) {
      return _buildLoadingView();
    }

    return _buildLoadingView();
  }

  Widget _buildLoadingView() {
    return Container(
      color: const Color(0xFF4FADF9),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Display different images based on the platform
            if (kIsWeb)
              Image.asset(
                getImageUrl(path: 'startup', type: ImageType.png),
                fit: BoxFit.fill,
              )
            else if (Platform.isAndroid)
              Image.asset(
                getImageUrl(path: 'startup', type: ImageType.png),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
            else if (Platform.isIOS)
                Image.asset(
                  getImageUrl(path: 'startup', type: ImageType.png),
                  fit: BoxFit.contain,
                )
              else
                Image.asset(
                  getImageUrl(path: 'startup', type: ImageType.png),
                  fit: BoxFit.contain,
                ),

            // Circular Progress Indicator in the center
            const CircularProgressIndicator(
              strokeWidth: 4,
              color: Primitives.bluePrimary, // Same as in your design
              backgroundColor: Primitives.white,
              strokeCap: StrokeCap.round,
            ),
          ],
        ),
      ),
    );
  }
}
