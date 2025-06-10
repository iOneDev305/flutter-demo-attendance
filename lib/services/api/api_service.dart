import 'package:dio/dio.dart';

import '../../config/config.dart';
import '../../utils/constant/constant.dart';
import 'api_endpoints.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio) {
    _dio.options.baseUrl = Config.baseUrl;
    _dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=utf-8',
      Config.apiHeader: Config.apiKey,
    };

    // Timeout settings with Duration
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
  }

  // Helper method to convert Map params to FormData
  FormData _convertToFormData(Map<String, dynamic> params) {
    return FormData.fromMap(params);
  }

  // API methods
  Future<Response> postUserLogin(Map<String, dynamic> params) async {
    return _dio.post(ApiEndpoints.postUserLogin,
        data: _convertToFormData(params));
  }

  Future<Response> postUserLogout(Map<String, dynamic> params) async {
    return _dio.post(ApiEndpoints.postUserLogout,
        data: _convertToFormData(params));
  }

  Future<Response> getMyAccount(Map<String, dynamic> params) async {
    return _dio.get(ApiEndpoints.getMyAccount, queryParameters: params);
  }

  Future<Response> getELeave(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params');
    return _dio.get(ApiEndpoints.getELeave, queryParameters: params);
  }

  Future<Response> getELeaveCalculate(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params');
    return _dio.get(ApiEndpoints.getELeaveCalculate, queryParameters: params);
  }

  Future<Response> getELeaveView(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params');
    return _dio.get(ApiEndpoints.getELeaveView, queryParameters: params);
  }

  Future<Response> postELeaveCreate(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params');
    return _dio.post(ApiEndpoints.postELeaveCreate,
        data: _convertToFormData(params));
  }

  Future<Response> postELeaveApprove(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params');
    return _dio.post(ApiEndpoints.postELeaveApprove,
        data: _convertToFormData(params));
  }

  Future<Response> getELeaveType(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params');
    return _dio.get(ApiEndpoints.getELeaveType, queryParameters: params);
  }

  Future<Response> getMyBalance(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params');
    return _dio.get(ApiEndpoints.getMyBalance, queryParameters: params);
  }

  Future<Response> getDepartment(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params'); // Log the parameters
    return _dio.get(ApiEndpoints.getDepartment, queryParameters: params);
  }

  Future<Response> postFeedback(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params'); // Log the parameters
    return _dio.post(ApiEndpoints.postFeedback,
        data: _convertToFormData(params));
  }

  Future<Response> getUserListByDepartment(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params'); // Log the parameters
    return _dio.get(ApiEndpoints.getUserListByDepartment,
        queryParameters: params);
  }

  Future<Response> getAppVersion(Map<String, dynamic> params) async {
    return _dio.get(ApiEndpoints.getAppVersion, queryParameters: params);
  }

  Future<Response> postAttendancesCreate(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params');
    return _dio.post(ApiEndpoints.postAttendancesCreate,
        data: _convertToFormData(params));
  }

  Future<Response> getAttendancesIndex(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params');
    return _dio.get(ApiEndpoints.getAttendancesIndex, queryParameters: params);
  }

  Future<Response> getAttendancesMy(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params');
    return _dio.get(ApiEndpoints.getAttendancesMy, queryParameters: params);
  }

  Future<Response> postUpdatePlayerId(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params');
    return _dio.post(ApiEndpoints.postUpdatePlayerId,
        data: _convertToFormData(params));
  }

  Future<Response> getNotificationsIndex(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params');
    return _dio.get(ApiEndpoints.getNotificationsIndex, queryParameters: params);
  }

  Future<Response> getNotificationsView(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params');
    return _dio.get(ApiEndpoints.getNotificationsView, queryParameters: params);
  }

  Future<Response> postNotificationsRead(Map<String, dynamic> params) async {
    printDebug('Query Parameters: $params');
    return _dio.post(ApiEndpoints.postNotificationsRead,
        data: _convertToFormData(params));
  }

}
