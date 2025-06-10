import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../custom/app_bar.dart';
import '../../../../utils/connectivity/no_connection_screen.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/helper.dart';
import '../../../../utils/utils.dart';

import '../controller/sample_single_object_request_controller.dart';

class SampleSingleObjectRequestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SampleSingleObjectRequestController controller = Get.put(
      SampleSingleObjectRequestController(),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive padding based on screen width
        final double horizontalPadding = ResponsiveUtils.getHorizontalPadding(
          constraints,
        );
        return Scaffold(
          appBar: CustomAppBar(title: "Sample Single Object Request View".tr),
          body: Obx(() {
            if (!controller.isConnected.value) {
              return NoConnectionScreen(onRetry: controller.fetchItemData);
            }
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  color: Primitives.bluePrimary,
                  backgroundColor: Primitives.grey5,
                  strokeCap: StrokeCap.round,
                ),
              );
            }
            if (controller.errorMessage.value.isNotEmpty) {
              return errorWidget(controller);
            }

            final data = controller.item.value;
            if (data == null) {
              return const Center(child: Text('No data available'));
            }

            return SmartRefresher(
              controller: controller.refreshController,
              onRefresh: controller.onRefresh,
              header: CustomHeader(builder: (_, __) => const SizedBox.shrink()),
              enablePullDown: true,
              enablePullUp: false,
              // child: _buildContentTest(data),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    color: Colors.cyan,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.username),
                          Text(data.department),
                          Text(data.dateJoined),
                          Text(data.email),
                          Text(data.genderLabel),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
