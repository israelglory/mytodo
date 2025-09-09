import 'dart:developer';

import 'package:mytodo/core/cores.dart';
import 'package:mytodo/presentation/auth/sign_in/sign_in_view.dart';
import 'package:mytodo/presentation/bottom_navigation_view/bottom_navigation_view.dart';

import 'package:stacked/stacked.dart';

class SplashScreenVM extends BaseViewModel {
  Future<void> initializeSplashScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    final isAuthenticated = appGlobals.token != null;
    if (isAuthenticated) {
      navigationService.pushReplacement(const SignInView());
    } else {
      navigationService.pushReplacement(const SignInView());
      //navigationService.pushReplacement(const BottomNavigationView());
    }
  }
}
