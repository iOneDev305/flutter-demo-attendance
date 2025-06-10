import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../services/api/api_errors.dart';
import '../../services/api/api_manager.dart';
import '../../services/api/error_handler.dart';
import '../../utils/connectivity/connectivity_service.dart';
import '../../utils/parameters.dart';
import '../../views/authentication/login_user/model/login_user_manager.dart';

abstract class SingleObjectController<T> extends GetxController {
  var item = Rx<T?>(null);
  var isLoading = true.obs;
  var isFirstLoad = true.obs; // Add this variable
  var errorMessage = ''.obs;
  final ApiManager apiManager = ApiManager(Dio());
  RefreshController refreshController = RefreshController();

  final ConnectivityService _connectivityService =
      Get.find<ConnectivityService>();
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivityService.isConnected.listen((connected) {
      isConnected.value = connected;
      if (connected) {
        fetchItemData(); // Fetch data when connection is restored
      }
    });
    fetchItemData(); // Fetch data initially
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Future<void> fetchItemData() async {
    if (!isConnected.value) {
      errorMessage.value = 'No internet connection';
      return;
    }

    // Set loading state and reset error message before fetching data
    isLoading.value = isFirstLoad.value; // Show loading only for the first load
    errorMessage.value = '';

    final params = await ApiParamsHelper.getParams();

    try {
      final response = await fetchApi(params);
      _handleApiResponse(response);
    } catch (e) {
      if (e is DioException) {
        handleDioError(e);
      } else {
        handleNonDioError(e);
      }
    } finally {
      isLoading.value = false;
      isFirstLoad.value = false; // Mark first load as complete
      refreshController.refreshCompleted(); // End refreshing
    }
  }

  Future<void> _handleApiResponse(response) async {
    if (response == null) {
      errorMessage.value = 'No data received.';
      return;
    }
    if (response != null) {
      final data = response.data;
      if (data is Map<String, dynamic>) {
        item.value = fromJson(data);
      } else {
        errorMessage.value = 'Unexpected data format.';
      }
    } else if (response.code == ApiErrors.unauthorized) {
      await LoginUserManager.resetAndNavigateToLogin();
    } else {
      errorMessage.value = 'Error: ${response.msg ?? 'Unknown error.'}';
    }
  }

  Future<void> onRefresh() async {
    await fetchItemData();
  }

  // Abstract methods to be implemented by subclasses
  Future<dynamic> fetchApi(Map<String, dynamic> params);

  T fromJson(Map<String, dynamic> json);
}
