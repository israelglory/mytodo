import 'package:flutter/material.dart';
import 'package:mytodo/presentation/auth/sign_up/sign_up_view.dart';
import 'package:mytodo/presentation/profile/components/user_switch_widget.dart';
import 'package:stacked/stacked.dart';

import '../../core/cores.dart';
import '../../data/model/model.dart';
import '../../data/repo/auth_repository.dart';
import '../auth/sign_in/sign_in_view.dart';

class ProfileViewModel extends BaseViewModel {
  final _authRepository = AuthRepository();

  bool isBiometricsEnabled = appGlobals.isBiometricsEnabled;

  void toggleBiometrics(bool value) {
    isBiometricsEnabled = value;
    authLocalStorage.saveBiometric(value);
    appGlobals.biometrics = value;
    notifyListeners();
  }

  Future<void> showUserSwitchModal(BuildContext context) async {
    bottomSheetService.showReactive(
      viewModelBuilder: () => this,
      builder: (context, model) {
        return UserSwitchBottomSheet(
          users: appGlobals.allUsers,
          currentUser: appGlobals.user,
          onUserSelected: switchUser,
          addAccount: () {
            navigationService.push(SignUpView());
            //BottomSheetService.dismiss();
          },
        );
      },
    );
  }

  void addAccount() {
    navigationService.pop();
  }

  Future<void> switchUser(User selectedUser) async {
    if (selectedUser.email == appGlobals.user?.email) {
      return; // Already the current user
    }

    setBusy(true);

    try {
      // Create a user without password for current session
      final userWithoutPassword = User(
        id: selectedUser.id,
        email: selectedUser.email,
        username: selectedUser.username,
        password: '',
      );

      // Set the new user as current
      authRepository.switchUser(userWithoutPassword);
      notifyListeners();

      // Show success message
      _showSuccess('Switched to ${selectedUser.username}');

      // // Close the modal
      navigationService.pop();
    } catch (e) {
      _showError('An error occurred while switching users');
    } finally {
      setBusy(false);
    }
  }

  String getUserDisplayName(User user) {
    return user.username.isNotEmpty ? user.username : user.email.split('@')[0];
  }

  String getUserInitials(User user) {
    String name = getUserDisplayName(user);
    if (name.length >= 2) {
      return name.substring(0, 2).toUpperCase();
    } else if (name.length == 1) {
      return name.toUpperCase();
    }
    return 'U';
  }

  bool isCurrentUser(User user) {
    return user.email == appGlobals.user?.email;
  }

  Future<void> logout() async {
    setBusy(true);

    try {
      await _authRepository.signOut();
      appGlobals.user = null;

      // Navigate to sign in screen
      navigationService.pushReplacement(
        const SignInView(),
      );

      _showSuccess('Logged out successfully');
    } catch (e) {
      _showError('Failed to logout');
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
}
