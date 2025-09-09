import 'package:mytodo/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/cores.dart';
import 'data/datasources/local/base/local_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  //await Upgrader.clearSavedSettings();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  setupLocator();
  await LocalStorageService.init();
  await AppGlobals.instance.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //final notificationService = NotificationService();
  //final messaging = Messaging();
  // notificationService.requestPermission();
  // Messaging.registerNotification();
  // Messaging.setupInteractedMessage();
  // Messaging.checkForInitialMessage();
  // notificationService.getToken();

  runApp(const MyApp());
}

//2MXULZ7T7T
