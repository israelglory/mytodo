import 'package:mytodo/core/cores.dart';
import 'package:mytodo/data/repo/auth_repository.dart';
import 'package:mytodo/presentation/auth/sign_in/sign_in_view.dart';
import 'package:mytodo/presentation/bottom_navigation_view/bottom_navigation_view.dart';

import 'package:stacked/stacked.dart';

class SplashScreenVM extends BaseViewModel {
  final _authRepository = AuthRepository();

  Future<void> initializeSplashScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    final isAuthenticated = _authRepository.isAuthenticated();

    if (isAuthenticated) {
      navigationService.pushReplacement(const BottomNavigationView());
    } else {
      navigationService.pushReplacement(const SignInView());
    }
  }
}
