import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../../routes/route_constants.dart';
import '../../../../utils/constant/constant.dart';

class LoginUserManager {
  static const String _tokenKey = 'token';
  static const String _departmentId = 'department_id';
  static const String _username = 'username';
  static const String _profilePhoto = 'profile_photo';
  static const String _position = 'position';
  static const String _department = 'department';
  static const String _locationId = 'location_id';
  static const String _userId = 'user_id';
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Write
  static Future<void> saveToken(String tokenValue) async {
    await _secureStorage.write(key: _tokenKey, value: tokenValue);
  }

  static Future<void> saveDepartmentId(String departmentId) async {
    await _secureStorage.write(key: _departmentId, value: departmentId);
    printDebug(departmentId);
  }

  static Future<void> saveUsername(String username) async {
    await _secureStorage.write(key: _username, value: username);
    printDebug(username);
  }

  static Future<void> saveProfilePhoto(String profilePhoto) async {
    await _secureStorage.write(key: _profilePhoto, value: profilePhoto);
    printDebug(profilePhoto);
  }

  static Future<void> savePosition(String position) async {
    await _secureStorage.write(key: _position, value: position);
    printDebug(position);
  }

  static Future<void> saveDepartment(String department) async {
    await _secureStorage.write(key: _department, value: department);
    printDebug(department);
  }

  static Future<void> saveLocationId(String locationId) async {
    await _secureStorage.write(key: _locationId, value: locationId);
    printDebug(locationId);
  }

  static Future<void> saveUserId(String userId) async {
    await _secureStorage.write(key: _userId, value: userId);
    printDebug(userId);
  }

  // Read

  static Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  static Future<String?> getUsername() async {
    return await _secureStorage.read(key: _username);
  }

  static Future<String?> getProfilePhoto() async {
    return await _secureStorage.read(key: _profilePhoto);
  }

  static Future<String?> getPosition() async {
    return await _secureStorage.read(key: _position);
  }

  static Future<String?> getDepartment() async {
    return await _secureStorage.read(key: _department);
  }

  static Future<String?> getDepartmentId() async {
    return await _secureStorage.read(key: _departmentId);
  }

  static Future<String?> getLocationId() async {
    return await _secureStorage.read(key: _locationId);
  }

  static Future<String?> getUserId() async {
    return await _secureStorage.read(key: _userId);
  }

  // Delete

  static Future<void> resetToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  static Future<void> resetDepartmentId() async {
    await _secureStorage.delete(key: _departmentId);
  }

  static Future<void> resetUsername() async {
    await _secureStorage.delete(key: _username);
  }

  static Future<void> resetProfilePhoto() async {
    await _secureStorage.delete(key: _profilePhoto);
  }

  static Future<void> resetPosition() async {
    await _secureStorage.delete(key: _position);
  }

  static Future<void> resetDepartment() async {
    await _secureStorage.delete(key: _department);
  }

  static Future<String?> resetLocationId() async {
    await _secureStorage.delete(key: _locationId);
  }

  static Future<String?> resetUserId() async {
    await _secureStorage.delete(key: _userId);
  }

  static Future<void> resetAndNavigateToLogin() async {
    await resetToken();
    await resetDepartmentId();
    await resetUsername();
    await resetProfilePhoto();
    await resetPosition();
    await resetDepartment();
    await resetLocationId();
    await resetUserId();
    Get.offAllNamed(RouteConstants.userLogin);
  }
}
