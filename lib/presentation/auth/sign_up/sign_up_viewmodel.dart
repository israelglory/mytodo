import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get rememberMe => _rememberMe;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }

  Future<void> signUp() async {
    setBusy(true);

    // Add your sign in logic here
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    setBusy(false);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
