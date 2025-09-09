import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mytodo/core/di/locator.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
  }

  void getToken() async {
    String? token = Platform.isIOS
        ? await FirebaseMessaging.instance.getAPNSToken()
        : await FirebaseMessaging.instance.getToken();
    appLocalStorage.saveNotificationToken(token);
    appGlobals.notificationToken = token;
    log("FirebaseMessaging token: $token");
  }
}
