import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ione_office_intern/custom/custom_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../custom/app_bar.dart';
import '../../../../services/api/api_manager.dart';
import '../../../../utils/connectivity/no_connection_screen.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/helper.dart';
import '../../../../utils/utils.dart';
import '../controller/sample_single_object_with_nested_array_controller.dart';

class SampleSingleObjectWithNestedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      SampleSingleObjectWithNestedArrayController(ApiManager(Dio())),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = ResponsiveUtils.getHorizontalPadding(
          constraints,
        );

        return Scaffold(
          backgroundColor: Primitives.grey1,
          appBar: CustomAppBar(
            title: 'Sample Single Object With Nested View'.tr,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Obx(
              () => _buildBody(controller: controller, context: context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody({
    required SampleSingleObjectWithNestedArrayController controller,
    required BuildContext context,
  }) {
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
        await controller.onRefresh();
      },
      onLoading: () async {
        await controller.onLoading();
      },
      enablePullDown: true,
      enablePullUp: true,
      header: CustomHeader(builder: (_, __) => const SizedBox.shrink()),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomNetworkImage(
                      width: 36,
                      height: 36,
                      imageUrl: controller.userInfo?.profilePhoto ?? '',
                      borderRadius: 36,
                      borderColor: Primitives.bluePrimary,
                      borderWidth: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(controller.userInfo?.username ?? ""),
                    const SizedBox(height: 4),
                    Text(controller.userInfo?.userDepartment ?? ""),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          ),
          ListView.builder(
            itemCount: controller.items.length,
            shrinkWrap: true,
            // Prevents overflow
            physics: const NeverScrollableScrollPhysics(),
            // Disables inner scrolling
            itemBuilder: (context, index) {
              final data = controller.items[index];
              return ListTile(
                title: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(data.inLabel),
                  ),
                ),
              );
            },
          ),
        ],
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
