import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../routes/route_constants.dart';
import '../../../services/api/api_manager.dart';
import '../../../services/api/error_handler.dart';
import '../../../utils/constant/constant.dart';
import '../../../utils/parameters.dart';
import '../../account/model/account_model.dart';

class LaunchScreenController extends GetxController {
  var modelAccount = Rx<AccountModel?>(null);
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  final ApiManager _apiManager = ApiManager(Dio());

  get updatePlayerIdController => null;
  @override
  void onInit() {
    super.onInit();
    fetchAccountData();
  }

  Future<void> fetchAccountData() async {
    try {
      final params = await ApiParamsHelper.getParams();
      final additionalParams = await ApiParamsHelper.getParamsWithToken();
      params.addAll(additionalParams);

      final token = additionalParams['token'];

      // ✅ If params are empty, navigate to login
      if (params.isEmpty) {
        printDebug('Params are empty. Navigating to login...');
        await Future.delayed(const Duration(seconds: 1));
        Get.offNamed(RouteConstants.userLogin);
        return;
      }

      // ✅ Fetch account data
      final response = await _apiManager.getMyAccount(params);
      printDebug('Response: ${response?.data}');

      if (response != null && response.data is Map<String, dynamic>) {
        modelAccount.value = AccountModel.fromJson(response.data);
        await Future.delayed(const Duration(seconds: 1));
        Get.offNamed(RouteConstants.home);
      } else {
        errorMessage.value = 'Unexpected data format.';
      }
    } catch (e) {
      printDebug('Error: $e');
      if (e is DioException) {
        handleDioError(e);
      } else {
        handleNonDioError(e);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
