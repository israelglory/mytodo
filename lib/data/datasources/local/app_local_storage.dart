import 'package:hive/hive.dart';

import '../../../core/states/app_state.dart';
import '../../model/model.dart';
import 'base/hive_boxes.dart';
import 'base/local_storage_service.dart';
import 'base/storage_keys.dart';

class AppLocalStorage {
  final _localStorageService = LocalStorageService(Hive.box(HiveBoxes.appBox));

  void saveAppState(String value) {
    _localStorageService.save(StorageKeys.appState, value);
  }

  String getAppState() {
    return _localStorageService.getString(StorageKeys.appState) ??
        AppState.unauthenticated;
  }

  void saveCurrentUser(User? user) {
    _localStorageService.saveMap(StorageKeys.appUser, user?.toJson());
  }

  User? getCurrentUser() {
    final res = _localStorageService.getMap(StorageKeys.appUser);
    if (res == null) return null;
    return User.fromJson(res);
  }

  // Multi-user functionality
  void saveAllUsers(List<User> users) {
    final userJsonList = users.map((user) => user.toJson()).toList();
    _localStorageService.save(StorageKeys.allUsers, userJsonList);
  }

  List<User> getAllUsers() {
    final res = _localStorageService.box.get(StorageKeys.allUsers);
    if (res == null) return [];

    final List<dynamic> userJsonList = res as List<dynamic>;
    return userJsonList
        .map((json) => User.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  User? findUserByEmail(String email) {
    final users = getAllUsers();
    try {
      return users.firstWhere(
        (user) => user.email.toLowerCase() == email.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  bool emailExists(String email) {
    return findUserByEmail(email) != null;
  }

  void addUser(User user) {
    final users = getAllUsers();
    users.add(user);
    saveAllUsers(users);
  }

  void updateUser(User updatedUser) {
    final users = getAllUsers();
    final index = users.indexWhere(
      (user) => user.email.toLowerCase() == updatedUser.email.toLowerCase(),
    );
    if (index != -1) {
      users[index] = updatedUser;
      saveAllUsers(users);
    }
  }

  void removeUser(String email) {
    final users = getAllUsers();
    users.removeWhere(
      (user) => user.email.toLowerCase() == email.toLowerCase(),
    );
    saveAllUsers(users);
  }

  void saveNotificationToken(String? value) {
    _localStorageService.save(StorageKeys.notificationToken, value);
  }

  String? getNotificationToken() {
    return _localStorageService.getString(StorageKeys.notificationToken);
  }

  // Backward compatibility
  void saveUser(User? user) {
    saveCurrentUser(user);
  }

  User? getUser() {
    return getCurrentUser();
  }
}
