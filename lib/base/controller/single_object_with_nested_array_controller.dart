import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../custom/custom_dialog.dart';
import '../../../custom/custom_toast.dart';
import '../../../services/api/api_errors.dart';
import '../../../services/api/api_manager.dart';
import '../../../utils/connectivity/connectivity_service.dart';
import '../../../utils/parameters.dart';
import '../../services/api/error_handler.dart';
import '../../views/authentication/login_user/model/login_user_manager.dart';

enum FetchType { data, reload }

abstract class SingleObjectWithNestedArrayController<T, U>
    extends GetxController {
  U? userInfo;
  var items = <T>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var page = 1.obs;

  final ApiManager apiManager;
  final RefreshController refreshController = RefreshController();
  final ConnectivityService _connectivityService =
      Get.find<ConnectivityService>();
  var isConnected = true.obs;

  SingleObjectWithNestedArrayController(this.apiManager);

  @override
  void onInit() {
    super.onInit();
    _connectivityService.isConnected.listen(_onConnectionChange);
    fetchContent(fetchType: FetchType.data);
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  void _onConnectionChange(bool connected) {
    isConnected.value = connected;
    if (connected) {
      fetchContent(
          fetchType: FetchType.data); // Fetch data when connection is restored
    }
  }

  Future<void> fetchContent({
    required FetchType fetchType,
    BuildContext? context,
    bool refresh = false,
  }) async {
    if (!isConnected.value) {
      _handleNoConnection();
      return;
    }

    if (refresh) {
      _resetPagination();
    }

    errorMessage.value = '';

    // For `FetchType.reload`, show loading dialog if context is provided
    if (fetchType == FetchType.reload && context != null) {
      showLoadingDialog(context);
    }

    try {
      final params = await _buildRequestParams();
      final response = await fetchApi(params);

      if (response != null && response.code == ApiErrors.ok) {
        _processSuccessResponse(response, refresh);

        // Close loading dialog on success for `FetchType.reload`
        if (fetchType == FetchType.reload && context != null) {
          Navigator.of(context).pop();
        }
      } else if (response?.code == ApiErrors.unauthorized) {
        await LoginUserManager.resetAndNavigateToLogin();
        showCustomToast(message: '${response?.msg}', status: Status.warning);
      } else {
        _handleErrorResponse(response?.msg ?? 'Unknown error occurred');

        // Close loading dialog on error for `FetchType.reload`
        if (fetchType == FetchType.reload && context != null) {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      if (e is DioException) {
        handleDioError(e);
      } else {
        handleNonDioError(e);
      }
      refreshController.refreshFailed();
      refreshController.loadFailed();

      // Close loading dialog on exception for `FetchType.reload`
      if (fetchType == FetchType.reload && context != null) {
        Navigator.of(context).pop();
      }
    } finally {
      if (fetchType == FetchType.data) {
        isLoading.value = false;
      }
    }
  }

  Future<void> onRefresh() async {
    if (items.length == 1) {
      await fetchContent(fetchType: FetchType.data);
    } else {
      await fetchContent(fetchType: FetchType.data, refresh: true);
    }
    refreshController.refreshCompleted();
  }

  Future<void> onReload(BuildContext context) async {
    await fetchContent(
        fetchType: FetchType.reload, context: context, refresh: true);
  }

  Future<void> onLoading() async {
    await fetchContent(fetchType: FetchType.data);
  }

  Future<Map<String, dynamic>> _buildRequestParams() async {
    final params = await ApiParamsHelper.getParams();
    params['page'] = page.value.toString();
    params['num'] = kIsWeb ? "20" : "10";
    return params;
  }

  void _processSuccessResponse(dynamic response, bool refresh) {
    userInfo = fromJsonUser(response.data); // Set user info
    final List<T> newItems = fromJsonList(response.data['lists'] ?? []);

    if (refresh) {
      items.clear(); // Clear items on refresh
    }

    if (newItems.isNotEmpty) {
      items.addAll(newItems);
      refreshController.loadComplete();
      page.value +=
          1; // Increment page for the next load only if there are new items
    } else {
      refreshController.loadNoData(); // No more data to load
    }
  }

  void _handleErrorResponse(String message) {
    errorMessage.value = message;
    refreshController.refreshFailed();
    refreshController.loadFailed();
  }

  void _handleNoConnection() {
    errorMessage.value = 'No internet connection';
    refreshController.refreshFailed();
    refreshController.loadFailed();
  }

  void _resetPagination() {
    page.value = 1;
    refreshController.resetNoData();
  }

  // Abstract methods for subclasses to implement
  Future<dynamic> fetchApi(Map<String, dynamic> params);

  U fromJsonUser(Map<String, dynamic> json);

  List<T> fromJsonList(List<dynamic> jsonList);
}
