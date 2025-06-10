import 'dart:convert';

import 'package:dio/dio.dart';

import '../../models/api_model.dart';
import '../../utils/constant/constant.dart';
import 'api_errors.dart';
import 'api_service.dart';

class ApiManager {
  final ApiService _apiService;

  ApiManager(Dio dio) : _apiService = ApiService(dio);

  // Common response handling method
  ApiModel? _handleResponse(Response response) {
    printDebug('API response data type: ${response.data.runtimeType}');
    printDebug('API response data: ${response.data}');
    if (response.statusCode == ApiErrors.ok) {
      // Handle the response data based on its type
      final responseData = response.data is String
          ? jsonDecode(response.data as String) as Map<String, dynamic>
          : response.data as Map<String, dynamic>;
      // Validate that the response data contains the required fields
      if (responseData.containsKey('code') && responseData.containsKey('msg')) {
        return ApiModel.fromJson(responseData);
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      // Handle non-success status codes
      throw Exception('Error: ${response.statusCode}');
    }
  }

  Future<ApiModel?> postUserLogin(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.postUserLogin(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> postUserLogout(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.postUserLogout(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> getMyAccount(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.getMyAccount(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> getELeave(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.getELeave(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> getELeaveCalculate(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.getELeaveCalculate(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> postELeaveCreate(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.postELeaveCreate(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> postEleaveApprove(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.postELeaveApprove(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> getELeaveView(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.getELeaveView(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> getELeaveType(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.getELeaveType(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> getMyBalance(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.getMyBalance(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> getDepartment(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.getDepartment(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> postFeedback(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.postFeedback(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> getUserListByDepartment(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.getUserListByDepartment(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> getAppVersion(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.getAppVersion(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> postAttendancesCreate(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.postAttendancesCreate(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> getAttendancesIndex(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.getAttendancesIndex(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> getAttendancesMy(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.getAttendancesMy(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> postUpdatePlayerId(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.postUpdatePlayerId(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }


  Future<ApiModel?> getNotificationsIndex(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.getNotificationsIndex(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> getNotificationsView(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.getNotificationsView(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }

  Future<ApiModel?> postNotificationsRead(Map<String, dynamic> params) async {
    try {
      final response = await _apiService.postNotificationsRead(params);
      return _handleResponse(response);
    } catch (e) {
      printDebug('API call error: $e');
      rethrow;
    }
  }
}
