import 'package:flutter/material.dart';

import 'dart:io' show Platform;

import '../../data/model/model.dart';
import '../cores.dart';

class AppGlobals extends ChangeNotifier {
  static AppGlobals instance = AppGlobals._();
  AppGlobals._();

  String? _token;
  String? _refreshToken;
  String? _notificationToken;
  User? _user;
  bool? subscribed;
  String? subscriptionPlan;
  bool? isBiometricEnabled;
  DateTime? _tokenExpiry;

  Future<void> init() async {
    _token = authLocalStorage.getToken();
    _refreshToken = authLocalStorage.getRefreshToken();
    _user = appLocalStorage.getUser();
    _tokenExpiry = authLocalStorage.getTokenExpiry();

    _notificationToken = appLocalStorage.getNotificationToken();
    isBiometricEnabled = authLocalStorage.getBiometrics();
  }

  set token(String? value) {
    _token = value;
    notifyListeners();
  }

  set refreshToken(String? value) {
    _refreshToken = value;
    notifyListeners();
  }

  set tokenExpiry(DateTime? value) {
    _tokenExpiry = value;
    notifyListeners();
  }

  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  set biometrics(bool? value) {
    isBiometricEnabled = value;
    notifyListeners();
  }

  set isSubscribed(bool? value) {
    subscribed = value;
    notifyListeners();
  }

  set setSubscriptionPlan(String? value) {
    subscriptionPlan = value;
    notifyListeners();
  }

  set notificationToken(String? value) {
    _notificationToken = value;
    notifyListeners();
  }

  String? get token => _token;
  DateTime? get tokenExpiry => _tokenExpiry;
  User? get user => _user;

  String? get notificationToken => _notificationToken;
  bool get isSubscribed => subscribed ?? false;
  String? get refreshToken => _refreshToken;
  String? get getSubscriptionPlan => subscriptionPlan;
  bool get isBiometricsEnabled => isBiometricEnabled ?? false;
  bool get isAndroid => Platform.isAndroid;
}
