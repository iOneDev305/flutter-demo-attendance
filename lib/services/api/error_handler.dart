import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../custom/custom_toast.dart';
import '../../models/api_model.dart';
import '../../utils/constant/constant.dart';
import '../../views/authentication/login_user/model/login_user_manager.dart';
import 'api_errors.dart';

final errorMessage = ''.obs;

void handleDioError(DioException e) {
  errorMessage.value = 'Network error: ${e.message}';
  switch (e.type) {
    case DioExceptionType.connectionError:
    case DioExceptionType.receiveTimeout:
      showCustomToast(
        message: 'no_internet_connection'.tr,
        status: Status.warning,
      );
      break;

    case DioExceptionType.connectionTimeout:
      showCustomToast(
        message: 'connection_timeout'.tr,
        status: Status.warning,
      );
      break;

    case DioExceptionType.sendTimeout:
      showCustomToast(
        message: 'send_timeout'.tr,
        status: Status.warning,
      );
      break;

    case DioExceptionType.badResponse:
      handleBadResponse(e);
      break;

    case DioExceptionType.cancel:
      showCustomToast(
        message: 'request_cancelled'.tr,
        status: Status.warning,
      );
      break;

    case DioExceptionType.unknown:
      showCustomToast(
        message: 'unexpected_error_occurred'.tr,
        status: Status.warning,
      );
      break;

    case DioExceptionType.badCertificate:
      showCustomToast(
        message: 'certificate_error'.tr,
        status: Status.warning,
      );
      break;
  }
}

void handleBadResponse(DioException e) {
  final responseData = e.response?.data;
  ApiModel? apiResponse;

  try {
    // Parse response data into ApiModel
    if (responseData is String) {
      apiResponse = ApiModel.fromJson(jsonDecode(responseData));
    } else if (responseData is Map<String, dynamic>) {
      apiResponse = ApiModel.fromJson(responseData);
    }

    // Handle specific HTTP status codes
    if (e.response?.statusCode == ApiErrors.unauthorized) {
      showCustomToast(
        message: apiResponse?.msg?.tr ?? 'unauthorized_access'.tr,
        status: Status.warning,
      );
      Future.delayed(const Duration(seconds: 1));
      LoginUserManager.resetAndNavigateToLogin();
    } else if (e.response?.statusCode == ApiErrors.unprocessableEntity){
      printDebug(apiResponse?.msg ?? "");
    } else {
      showCustomToast(
        message: apiResponse?.msg?.tr ??
            e.response?.statusMessage?.tr ??
            'unknown_error'.tr,
        status: Status.warning,
      );
    }
  } catch (parseError) {
    // Handle parsing errors gracefully
    printDebug('Error parsing response: $parseError');
    showCustomToast(
      message: 'unexpected_error_occurred'.tr,
      status: Status.warning,
    );
  }
}

void handleNonDioError(dynamic e) {
  errorMessage.value = 'An unexpected error occurred: $e';
  showCustomToast(
    message: '$e'.tr,
    status: Status.warning,
  );
}
