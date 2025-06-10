import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../custom/custom_network_image.dart';
import '../../../routes/route_constants.dart';
import '../../../utils/connectivity/no_connection_screen.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/constant/constant.dart';
import '../../../utils/constant/enum_type.dart';
import '../../../utils/constant/fonts_style.dart';
import '../../../utils/helper.dart';
import '../../../utils/utils.dart';
import '../../authentication/login_user/model/login_user_manager.dart';
import '../controller/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive padding based on screen width
        final double horizontalPadding =
            ResponsiveUtils.getHorizontalPadding(constraints);
        final mediaQuery = MediaQuery.of(context);
        final hasSoftNavigationBar = mediaQuery.padding.bottom > 0;

        return Scaffold(
          backgroundColor: Primitives.bluePrimary,
          appBar: AppBar(
            backgroundColor: Primitives.bluePrimary,
            surfaceTintColor: Primitives.bluePrimary,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark, // For iOS status bar color
            ),
          ),
          body: Container(
              color: Primitives.grey1,
              child: Obx(() => _buildBody(
                  controller,
                  context,
                  horizontalPadding,
                  hasSoftNavigationBar,
                  mediaQuery))),
        );
      },
    );
  }

  Widget _buildBody(
      HomeController controller,
      BuildContext context,
      double horizontalPadding,
      hasSoftNavigationBar,
      mediaQuery) {
    if (!controller.isConnected.value) {
      return NoConnectionScreen(onRetry: controller.fetchItemData);
    }
    if (controller.isLoading.value) {
      return Container();
    }
    if (controller.errorMessage.value.isNotEmpty) {
      return errorWidget(controller);
    }

    final data = controller.item.value;
    if (data == null) {
      return const Center(child: Text('No data available'));
    }

    LoginUserManager.saveDepartmentId(data.departmentId);
    LoginUserManager.saveDepartment(data.department);
    LoginUserManager.savePosition(data.position);
    LoginUserManager.saveProfilePhoto(data.profilePhoto);
    LoginUserManager.saveUsername(data.username);
    LoginUserManager.saveLocationId("${data.locationId}");
    LoginUserManager.saveUserId("${data.id}");

    return Stack(
      children: [
        SmartRefresher(
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          enablePullDown: true,
          header: CustomHeader(
            builder: (_, __) => Container(
              width: ScreenSize.screenWidth(context),
              height: ScreenSize.screenHeight(context),
              color: Primitives.bluePrimary,
            ),
          ),
          child: _buildContent(data, context, horizontalPadding),
        ),
      ],
    );
  }

  Widget _buildAvailableUpdate(BuildContext context,versionController, hasSoftNavigationBar, mediaQuery) {
    if (kIsWeb) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: hasSoftNavigationBar ? mediaQuery.padding.bottom : 10),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: Primitives.blue5,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // Left-aligned message
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    "new_update_is_available".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: appFont,
                      fontSize: 12,
                      fontWeight: bold,
                      color: TextColor.light.color,
                    ),
                  ),
                ),
              ),
              // Right-aligned "Update Now" button
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 54),
                  child: GestureDetector(
                    onTap: () => versionController.openStore(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Primitives.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Text(
                        "update_now".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: appFont,
                          fontSize: 12,
                          fontWeight: medium,
                          color: TextColor.darkBlue.color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Right-aligned close button
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () =>
                        versionController.showUpdateBanner.value = false,
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Primitives.white,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        getIconUrl(
                          path: 'ic_close',
                          type: ImageType.svg,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(data, BuildContext context, horizontalPadding) {
    return SingleChildScrollView(
      child: Container(
        color: Primitives.grey1,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 170,
                color: Primitives.bluePrimary,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Container(
                color: Primitives.grey1,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      _buildSectionProfile(data, context),
                      _buildSectionMenu(context)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionProfile(data, BuildContext context) {
    String num = "${data.notificationCount}";

    return Container(
      color: Primitives.bluePrimary,
      height: 170,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteConstants.myAccount);
              },
              child: CustomNetworkImage(
                width: 48,
                height: 48,
                imageUrl: data.profilePhoto,
                placeholderImage: 'assets/icons/placeholder_logo.png',
                borderRadius: 48,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(RouteConstants.myAccount);
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'hello'.tr,
                          style: TextStyle(
                            fontFamily: appFont,
                            fontSize: 14,
                            color: TextColor.lightBlue.color,
                          ),
                          children: [
                            TextSpan(
                              text: data.username,
                              style: TextStyle(
                                fontFamily: appFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: TextColor.light.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.email,
                        style: TextStyle(
                          fontFamily: appFont,
                          fontSize: 12,
                          color: TextColor.lightBlue.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteConstants.sampleRequestView);
              },
              child: Container(
                color: Colors.transparent,
                height: 48,
                width: 55,
                child: Stack(
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Primitives.grey2, // Tint color
                          BlendMode.srcIn,
                        ),
                        getIconUrl(
                            path: "ic_notification", type: ImageType.svg),
                        width: 32,
                        height: 32,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 26,
                      child: Visibility(
                        visible: num != "0",
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            child:
                                int.tryParse(num) != null && int.parse(num) > 99
                                    ? Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "99",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: appFont,
                                                // Ensure appFont is defined
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            WidgetSpan(
                                              child: Transform.translate(
                                                offset: const Offset(0, -5),
                                                // Adjust vertical position
                                                child: Text(
                                                  "+",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: appFont,
                                                    fontSize: 8,
                                                    // Adjustable superscript size
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    : Text(
                                        num,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: appFont,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 104),
      child: Container(
        decoration: BoxDecoration(
          color: Primitives.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: Text(
                  "menu".tr,
                  style: TextStyle(
                    fontFamily: appFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: TextColor.darkGrey.color,
                  ),
                ),
              ),
              // _buildContentMenuGrid(context),
              _buildContentMenuList(context),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildContentMenuList(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        // Conditional content for web or mobile
        const SizedBox(
          height: 6,
        ),

        GestureDetector(
          onTap: () {
            Get.toNamed(RouteConstants.sampleRequestView);
          },
          child: _buildContentItemsList(
            context: context,
            leadingIcons: "ic_notification",
            title: "Sample For Request API".tr,
          ),
        ),

        const SizedBox(
          height: 6,
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteConstants.myAccount);
          },
          child: _buildContentItemsList(
            context: context,
            leadingIcons: "account",
            title: "account".tr,
          ),
        ),
      ],
    );
  }

  Widget _buildContentItemsList(
      {required String leadingIcons,
      required String title,
      required BuildContext context}) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Primitives.grey2,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      colorFilter: ColorFilter.mode(
                        IconsColors.iconDarkGrey.color, // Tint color
                        BlendMode.srcIn,
                      ),
                      getIconUrl(
                        path: leadingIcons,
                        type: ImageType.svg,
                      ),
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
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
      ),
    );
  }
}
