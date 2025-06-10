import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../custom/custom_toast.dart';
import '../../../../routes/route_constants.dart';
import '../../../../services/api/api_errors.dart';
import '../../../../services/api/api_manager.dart';
import '../model/login_user_manager.dart';

class LoginUserController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Observables for the form state
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString username = ''.obs; // Tracks the username input
  final RxString password = ''.obs; // Tracks the password input

  final ApiManager _apiManager = ApiManager(Dio());


  @override
  void onInit() {
    super.onInit();

    // Listen to changes in the text fields and update observables
    usernameController.addListener(() {
      username.value = usernameController.text.trim();
    });

    passwordController.addListener(() {
      password.value = passwordController.text.trim();
    });
  }

  // Login function that validates inputs and handles API call
  Future<void> login() async {
    // Check if both username and password are not empty
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      errorMessage.value = 'Please enter both username and password.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    final params = {
      'username': usernameController.text,
      'password': passwordController.text,
    };

    try {
      final response = await _apiManager.postUserLogin(params);

      if (response != null && response.code == ApiErrors.ok) {
        final token = response.data?['token']?.toString();
        if (token != null) {
          await LoginUserManager.saveToken(token); // Save the token securely
          Get.offAllNamed(RouteConstants.home); // Navigate to home
          showCustomToast(message: '${response.msg}', status: Status.success);

        } else {
          errorMessage.value = 'UID not found in login response.';
        }
      } else {
        errorMessage.value = 'Unexpected response from server.';
        showCustomToast(message: '${response?.msg}', status: Status.fail);
      }
    } catch (e) {
      if (e is DioException) {
        // Handling DioException
        errorMessage.value = 'Network error: ${e.message}';
        // Check if the error is a connection error
        if (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.receiveTimeout) {
          // Show specific message for no internet connection
          showCustomToast(
            message: 'no_internet_connection'.tr, // Ensure this is in your localization
            status: Status.warning,
          );
        } else {
          // Handle other types of DioException errors if needed
          showCustomToast(
            message: '${e.message}'.tr,
            status: Status.warning,
          );
        }
      } else {
        // Handle non-Dio errors
        errorMessage.value = 'An unexpected error occurred: $e';
        showCustomToast(
          message: '$e'.tr,
          status: Status.warning,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
