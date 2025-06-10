import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/constant/colors.dart';
import '../../../../utils/constant/enum_type.dart';
import '../../../../utils/constant/fonts_style.dart';
import '../../../../utils/utils.dart';
import '../controller/login_user_controller.dart';

class LoginUserView extends StatefulWidget {
  @override
  _LoginUserViewState createState() => _LoginUserViewState();
}

class _LoginUserViewState extends State<LoginUserView> {
  final LoginUserController controller = Get.put(LoginUserController());
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context);
    final hasSoftNavigationBar = mediaQuery.padding.bottom > 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Primitives.white,
        surfaceTintColor: Primitives.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light, // For iOS status bar color
        ),
        toolbarHeight: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive padding based on screen width
          double horizontalPadding = (constraints.maxWidth > 1200)
              ? 120.0
              : (constraints.maxWidth > 800)
                  ? 80.0
                  : 20.0;

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Obx(() {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenWidth * 0.16),
                        _buildLogo(screenWidth),
                        const SizedBox(height: 24),
                        _buildWelcomeText(),
                        const SizedBox(height: 16),
                        _buildLoginInstructionText(),
                        const SizedBox(height: 120),
                        _buildUsernameField(),
                        const SizedBox(height: 24),
                        _buildPasswordField(),
                        const SizedBox(height: 76),
                        _buildSignInButton(),
                        SizedBox(
                            height: hasSoftNavigationBar
                                ? mediaQuery.padding.bottom
                                : 10),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          getImageUrl(path: "logo_login", type: ImageType.svg),
          width: 90,
        ),
      ],
    );
  }

  Widget _buildWelcomeText() {
    return Text(
      "welcome_back".tr,
      style: TextStyle(
        fontFamily: appFont,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: TextColor.darkGrey.color,
      ),
    );
  }

  Widget _buildLoginInstructionText() {
    return Text(
      "login_to_your_account".tr,
      style: TextStyle(
        fontFamily: appFont,
        fontSize: 14,
        fontWeight: medium,
        color: TextColor.lightGrey.color,
      ),
    );
  }

  Widget _buildUsernameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "enter_your_username".tr,
            style: TextStyle(
              fontFamily: appFont,
              fontSize: 12,
              fontWeight: medium,
              color: TextColor.grey.color,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controller.usernameController,
          style: TextStyle(
            fontFamily: appFont,
            fontSize: 14,
            fontWeight: semiBold,
            color: TextColor.darkGrey.color,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Primitives.grey1,
            hintText: "username".tr,
            hintStyle: TextStyle(
              fontFamily: appFont,
              fontSize: 14,
              fontWeight: semiBold,
              color: TextColor.lightGrey.color,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "enter_your_password".tr,
            style: TextStyle(
              fontFamily: appFont,
              fontSize: 12,
              fontWeight: medium,
              color: TextColor.grey.color,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controller.passwordController,
          obscureText: !_isPasswordVisible,
          textInputAction: TextInputAction.done,
          style: TextStyle(
            fontFamily: appFont,
            fontSize: 14,
            fontWeight: semiBold,
            color: TextColor.darkGrey.color,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Primitives.grey1,
            hintText: "password".tr,
            hintStyle: TextStyle(
              fontFamily: appFont,
              fontSize: 14,
              fontWeight: semiBold,
              color: TextColor.lightGrey.color,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 22),
              child: GestureDetector(
                onTap: () => setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                }),
                child: SvgPicture.asset(
                  getImageUrl(
                    path: _isPasswordVisible ? "eye" : "eye_off",
                    type: ImageType.svg,
                  ),
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    bool isButtonEnabled = controller.username.value.isNotEmpty &&
        controller.password.value.length >= 2;
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: (controller.isLoading.value || !isButtonEnabled)
            ? null
            : controller.login,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: controller.isLoading.value || !isButtonEnabled
                ? Primitives.blue3 // Disabled color
                : Button.buttonBlue.color, // Enabled color
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
                    "sign_in".tr,
                    style: TextStyle(
                      fontFamily: appFont,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: TextColor.light.color,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
