import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../custom/app_bar.dart';
import '../../../../utils/connectivity/no_connection_screen.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/helper.dart';
import '../../../../utils/utils.dart';

import '../controller/sample_array_of_object_request_controller.dart';

class SampleArrayOfObjectRequestView extends StatelessWidget {
  final SampleArrayOfObjectRequestController controller = Get.put(SampleArrayOfObjectRequestController());

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding =
        ResponsiveUtils.getHorizontalPadding(constraints);

        return Scaffold(
          backgroundColor: Primitives.grey1,
          appBar: CustomAppBar(
            title: 'Sample Array Of Object Request View'.tr,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Obx(() => _buildBody()), // Observe state changes
          ),
        );
      },
    );
  }

  Widget _buildBody() {

    if (!controller.isConnected.value) {
      return NoConnectionScreen(onRetry: controller.onRefresh);
    }

    if (controller.isLoading.value) {
      return _loadingIndicator();
    }

    if (controller.errorMessage.value.isNotEmpty) {
      return errorWidget(controller);
    }

    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: () async {
        controller.onRefresh();
      },
      onLoading: () async {
        controller.onLoading();
      },
      enablePullDown: true,
      enablePullUp: true,
      child: ListView.builder(
        padding: const EdgeInsets.all(32),
        itemCount: controller.items.length,
        itemBuilder: (context, index) {
          final data = controller.items[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.cyan,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data.name),
              ),

            ),
          );
        },
      ),
    );
  }


  Widget _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 6,
        color: Primitives.bluePrimary,
        backgroundColor: Primitives.grey5,
        strokeCap: StrokeCap.round,
      ),
    );
  }

}
