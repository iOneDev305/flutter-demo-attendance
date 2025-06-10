import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../custom/custom_toast.dart';
import '../../../../services/api/api_errors.dart';
import '../../../../services/api/api_manager.dart';
import '../../../../utils/parameters.dart';
import '../../login_user/model/login_user_manager.dart';

class LogoutUserController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final ApiManager _apiManager = ApiManager(Dio());

  Future<void> logout() async {
    if (isLoading.value) return; // Prevent multiple calls
    isLoading.value = true;

    try {
      final params = await ApiParamsHelper.getParams();
      final additionalParams = await ApiParamsHelper.getParamsWithToken();
      params.addAll(additionalParams);

      final response = await _apiManager.postUserLogout(params);

      if (response != null && response.code == ApiErrors.ok) {
        await LoginUserManager.resetAndNavigateToLogin();
        showCustomToast(
            message: response.msg ?? 'Logout successful.',
            status: Status.success);
      } else {
        final message = response?.msg ?? 'Logout failed. Please try again.';
        errorMessage.value = message;
        showCustomToast(message: message, status: Status.warning);
      }
    } on DioException catch (e) {
      errorMessage.value = 'Network error: ${e.message}';
      showCustomToast(
          message: 'Network error: ${e.message}', status: Status.fail);
    } catch (e) {
      errorMessage.value = 'Unexpected error: $e';
      showCustomToast(
          message: 'An unexpected error occurred.', status: Status.fail);
    } finally {
      isLoading.value = false;
    }
  }
}
