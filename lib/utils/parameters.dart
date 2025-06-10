import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'constant/constant.dart';

class ApiParamsHelper {
  static const String _tokenKey = 'token';
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Get parameters
  static Future<Map<String, dynamic>> getParams() async {
    return <String, dynamic>{};
  }

  // Get parameters with only token
  static Future<Map<String, dynamic>> getParamsWithToken() async {
    // Retrieve the token securely
    final token = await _secureStorage.read(key: _tokenKey) ?? '';

    final params = <String, dynamic>{};

    if (token.isNotEmpty) {
      params['token'] = token;
      printDebug("This token: $token");
    }
    return params;
  }
}
