import 'package:mytodo/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';

import '../core/di/locator.dart';
import 'core/constants/colors.dart';
import 'core/theme/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    ///refreshToken();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      toastTheme: ToastThemeData(
        background: AppColors.primaryColor,
        textColor: Colors.white,
      ),
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigationService.navigatorKey,
            title: 'My Todo',
            theme: AppTheme.lightTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
