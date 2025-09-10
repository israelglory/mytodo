import 'package:flutter/material.dart';
import 'package:mytodo/core/cores.dart';
import 'package:mytodo/presentation/auth/sign_in/sign_in_view.dart';
import 'package:mytodo/presentation/bottom_navigation_view/bottom_navigation_view.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<void> signUp() async {
    // Validate input
    if (userNameController.text.trim().isEmpty) {
      _showError('Please enter your username');
      return;
    }

    if (emailController.text.trim().isEmpty) {
      _showError('Please enter your email');
      return;
    }

    if (!_isValidEmail(emailController.text.trim())) {
      _showError('Please enter a valid email address');
      return;
    }

    if (passwordController.text.isEmpty) {
      _showError('Please enter a password');
      return;
    }

    if (passwordController.text.length < 6) {
      _showError('Password must be at least 6 characters long');
      return;
    }

    setBusy(true);

    try {
      final result = await authRepository.signUp(
        email: emailController.text.trim(),
        password: passwordController.text,
        userName: userNameController.text.trim(),
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

  void navigateToSignIn() {
    navigationService.pushReplacement(const SignInView());
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _showError(String message) {
    snackbarService.error(message: message);
  }

  void _showSuccess(String message) {
    snackbarService.success(message: message);
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
