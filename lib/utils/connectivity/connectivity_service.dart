import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeConnectivity();
  }

  void _initializeConnectivity() {
    // Check initial connection status
    checkConnection().then((connected) {
      isConnected.value = connected;
    });

    // Listen for connectivity changes
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      // Handle the list of connectivity results here
      // For simplicity, we'll assume the first result is sufficient
      isConnected.value =
          results.isNotEmpty && results.first != ConnectivityResult.none;
    });
  }

  Future<bool> checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
