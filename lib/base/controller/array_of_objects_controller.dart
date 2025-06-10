import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../custom/custom_dialog.dart';
import '../../services/api/api_errors.dart';
import '../../services/api/api_manager.dart';
import '../../utils/connectivity/connectivity_service.dart';
import '../../utils/parameters.dart';

abstract class ArrayOfObjectsController<T> extends GetxController {
  var items = <T>[].obs;
  var isLoading = true.obs;
  var isFirstLoad = true.obs;
  var errorMessage = ''.obs;
  var page = 1.obs;

  final ApiManager apiManager = ApiManager(Dio());
  final RefreshController refreshController = RefreshController();
  final ConnectivityService _connectivityService =
      Get.find<ConnectivityService>();
  var isConnected = true.obs; // Connectivity status

  @override
  void onInit() {
    super.onInit();
    _connectivityService.isConnected.listen((connected) {
      isConnected.value = connected;
      if (connected && isFirstLoad.value) {
        fetchData();
      }
    });
    fetchData();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  void addOrUpdateItems(List<T> newItems) {
    final existingItems = Set<T>.from(items);
    for (final newItem in newItems) {
      if (!existingItems.contains(newItem)) {
        items.add(newItem);
      }
    }
  }

  Future<void> fetchData({bool refresh = false}) async {
    if (!isConnected.value) {
      errorMessage.value = 'No internet connection';
      refreshController.refreshCompleted();
      return;
    }

    if (refresh) {
      page.value = 1; // Reset the page to 1 when refreshing
    }

    errorMessage.value = '';
    final params = await ApiParamsHelper.getParams();
    params['page'] = page.value.toString();
    params['num'] = "10";

    try {
      final response = await fetchApi(params);

      if (response != null && response.code == ApiErrors.ok) {
        final data = response.data as List<dynamic>;
        final List<T> newItems = fromJsonList(data);

        // Smooth update logic
        if (refresh && newItems.isNotEmpty) {
          items.assignAll(newItems); // Replace the items on refresh
        } else if (!refresh) {
          addOrUpdateItems(newItems); // Add new items if not refreshing
        }

        if (newItems.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
          page.value += 1;
        }
      } else {
        refreshController.loadNoData();
      }
    } catch (e) {
      errorMessage.value = 'Failed to load data: $e';
      refreshController.loadFailed();
    } finally {
      isLoading.value = false;
      isFirstLoad.value = false;
      refreshController.refreshCompleted();
    }
  }

  Future<void> onReload(BuildContext context) async {
    if (!isConnected.value) {
      errorMessage.value = 'No internet connection';
      return;
    }
    // Show the loading dialog
    showLoadingDialog(context);
    try {
      // Temporarily hold the current list while fetching new data
      final List<T> currentItems = List.from(items);

      await fetchData(refresh: true);

      // If new data is empty, restore the previous list (avoiding flash)
      if (items.isEmpty && currentItems.isNotEmpty) {
        items.assignAll(currentItems);
      }
    } catch (e) {
      errorMessage.value = 'Reload failed: $e';
    } finally {
      Navigator.of(context).pop();
    }
  }

  void onRefresh() async {
    await fetchData(refresh: true);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await fetchData();
  }

  // Abstract methods for API fetching and data mapping
  Future<dynamic> fetchApi(Map<String, dynamic> params);

  List<T> fromJsonList(List<dynamic> jsonList);
}
