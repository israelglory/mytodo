import 'package:mytodo/core/di/locator.dart';
import 'package:hive/hive.dart';

import 'base/hive_boxes.dart';
import 'base/local_storage_service.dart';
import 'base/storage_keys.dart';

class AuthLocalStorage {
  final _localStorageService = LocalStorageService(Hive.box(HiveBoxes.authBox));

  void saveToken(String? value) {
    _localStorageService.save(StorageKeys.token, value);
  }

  //SaveToken expiry date
  void saveTokenExpiry(DateTime? value) {
    _localStorageService.save(
      StorageKeys.tokenExpiry,
      value?.toIso8601String(),
    );
  }

  void saveBiometric(bool? value) {
    _localStorageService.save(StorageKeys.biometrics, value);
  }

  String? getToken() {
    return _localStorageService.getString(StorageKeys.token);
  }

  DateTime? getTokenExpiry() {
    final expiryString = _localStorageService.getString(
      StorageKeys.tokenExpiry,
    );
    if (expiryString == null) return null;
    return DateTime.tryParse(expiryString);
  }

  void saveRefreshToken(String? value) {
    _localStorageService.save(StorageKeys.refreshToken, value);
  }

  String? getRefreshToken() {
    return _localStorageService.getString(StorageKeys.refreshToken);
  }

  void saveLoginPin(String? value) {
    _localStorageService.save(StorageKeys.loginPin, value);
  }

  String? getLoginPin() {
    return _localStorageService.getString(StorageKeys.loginPin);
  }

  bool? getBiometrics() {
    return _localStorageService.getBool(StorageKeys.biometrics);
  }

  //Logout and clear token
  void logout() {
    _localStorageService.save(StorageKeys.token, null);
    _localStorageService.save(StorageKeys.refreshToken, null);
    appGlobals.token = null;
    appGlobals.refreshToken = null;
    appGlobals.user = null;
  }
}
