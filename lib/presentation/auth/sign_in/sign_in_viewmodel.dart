import 'package:flutter/material.dart';
import 'package:mytodo/core/cores.dart';
import 'package:mytodo/data/repo/auth_repository.dart';
import 'package:mytodo/presentation/bottom_navigation_view/bottom_navigation_view.dart';
import 'package:stacked/stacked.dart';

class SignInViewModel extends BaseViewModel {
  final _authRepository = AuthRepository();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  Future<void> signIn() async {
    // Validate input
    if (emailController.text.trim().isEmpty) {
      _showError('Please enter your email');
      return;
    }

    if (passwordController.text.isEmpty) {
      _showError('Please enter your password');
      return;
    }

    setBusy(true);

    try {
      final result = await _authRepository.signIn(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (result.success) {
        _showSuccess(result.message);
        // Navigate to main app
        navigationService.pushReplacement(const BottomNavigationView());
      } else {
        _showError(result.message);
      }
    } catch (e) {
      _showError('An unexpected error occurred. Please try again.');
    } finally {
      setBusy(false);
    }
  }

  void _showError(String message) {
    snackbarService.error(message: message);
  }

  void _showSuccess(String message) {
    snackbarService.success(message: message);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
