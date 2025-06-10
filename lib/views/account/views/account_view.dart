import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ione_office_intern/views/account/views/sheet/language_sheet.dart';
import 'package:ione_office_intern/views/account/views/sheet/logout_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../custom/app_bar.dart';
import '../../../../utils/connectivity/no_connection_screen.dart';
import '../../../custom/bottom_sheet.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/constant/constant.dart';
import '../../../utils/constant/enum_type.dart';
import '../../../utils/constant/fonts_style.dart';
import '../../../utils/helper.dart';
import '../../../utils/utils.dart';
import '../controller/account_controller.dart';
import '../model/overview_model.dart';

enum MenuItem {
  language,
}

class AccountView extends StatefulWidget {
  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {


  @override
  Widget build(BuildContext context) {
    final AccountController controller = Get.put(AccountController());
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive padding based on screen width
        final double horizontalPadding =
            ResponsiveUtils.getHorizontalPadding(constraints);
        return Scaffold(
          backgroundColor: Primitives.grey1,
          appBar: CustomAppBar(
            title: "account".tr,
          ),
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
              ));
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
              header: CustomHeader(
                builder: (_, __) => const SizedBox.shrink(),
              ),
              enablePullDown: true,
              enablePullUp: false,
              // child: _buildContentTest(data),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: _buildContent(data),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildContent(data) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildOverviewContent(),
            const SizedBox(height: 16),
            _buildButtonLogout(),
          ],
        ),
      ),
    );
  }


  Widget _buildOverviewContent() {
    return Container(
      decoration: BoxDecoration(
        color: Primitives.white,
        borderRadius: BorderRadius.circular(16),
      ),
      height: 100,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(), // Disable scroll
        padding: const EdgeInsets.symmetric(vertical: 22),
        itemCount: overviewList.length,
        itemBuilder: (context, index) {
          final data = overviewList[index];
          return GestureDetector(
            onTap: () => _onItemTap(index), // Pass the index to the handler.
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: _buildViewItems(
                  leadingIcons: data.leadingIcons,
                  title: data.titleKey.tr,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  MenuItem? getMenuItemByIndex(int index) {
    if (index < 0 || index >= MenuItem.values.length) {
      return null; // Handle invalid index
    }
    return MenuItem.values[index];
  }

  void _onItemTap(int index) {
    final menuItem = getMenuItemByIndex(index);
    switch (menuItem) {
      case MenuItem.language:
        customBottomSheet(context,
            title: "language".tr,
            content: LanguageSheet(),
            portraitHeight: 300);
        break;
      case null:
        break;
    }
  }


  Widget _buildViewItems(
      {required String leadingIcons, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                  getIconUrl(path: leadingIcons, type: ImageType.svg)),
              const SizedBox(width: 8),
              Text(title,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: appFont,
                      fontWeight: semiBold,
                      color: TextColor.darkGrey.color)),
            ],
          ),
          SvgPicture.asset(getIconUrl(path: "ic_next", type: ImageType.svg))
        ],
      ),
    );
  }

  Widget _buildButtonLogout() {
    return GestureDetector(
      onTap: () {
        printDebug("logout");
        customBottomSheet(
          context,
          title: 'logout'.tr,
          content: LogoutSheet(),
          portraitHeight: 320,
        );
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Primitives.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
            child: _buildViewItems(
                title: 'logout'.tr, leadingIcons: 'ic_account_logout')),
      ),
    );
  }
}
