import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:mytodo/core/cores.dart';
import '../model/model.dart';

class AuthRepository {
  // Hash password for security
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Generate unique ID
  String _generateUserId(String email) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final bytes = utf8.encode(email + timestamp);
    final digest = sha256.convert(bytes);
    return digest.toString().substring(0, 16);
  }

  // Sign up
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      // Check if email already exists
      if (appLocalStorage.emailExists(email)) {
        return AuthResult(
          success: false,
          message: 'An account with this email already exists',
        );
      }

      // Create new user
      final user = User(
        id: _generateUserId(email),
        email: email.toLowerCase().trim(),
        password: _hashPassword(password),
        username: userName.trim(),
      );

      // Save user to local storage
      appLocalStorage.addUser(user);

      // Set as current user and authenticate
      final userWithoutPassword = User(
        id: user.id,
        email: user.email,
        password: '', // Don't store password in current user
        username: user.username,
      );

      appLocalStorage.saveCurrentUser(userWithoutPassword);
      appLocalStorage.saveAppState('authenticated');
      appGlobals.user = userWithoutPassword;
      appGlobals.allUsers = appLocalStorage.getAllUsers();

      return AuthResult(
        success: true,
        message: 'Account created successfully',
        user: userWithoutPassword,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Failed to create account: ${e.toString()}',
      );
    }
  }

  // Sign in
  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Find user by email
      final user = appLocalStorage.findUserByEmail(email);

      if (user == null) {
        return AuthResult(
          success: false,
          message: 'Username or password is incorrect',
        );
      }

      // Verify password
      final hashedPassword = _hashPassword(password);
      if (user.password != hashedPassword) {
        return AuthResult(
          success: false,
          message: 'Username or password is incorrect',
        );
      }

      // Set as current user and authenticate
      final userWithoutPassword = User(
        id: user.id,
        email: user.email,
        password: '', // Don't store password in current user
        username: user.username,
      );

      appLocalStorage.saveCurrentUser(userWithoutPassword);
      appLocalStorage.saveAppState('authenticated');
      appGlobals.user = userWithoutPassword;
      appGlobals.allUsers = appLocalStorage.getAllUsers();

      return AuthResult(
        success: true,
        message: 'Login successful',
        user: userWithoutPassword,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Login failed: ${e.toString()}',
      );
    }
  }

  // Sign out
  Future<void> signOut() async {
    appLocalStorage.saveCurrentUser(null);
    appLocalStorage.saveAppState('unauthenticated');
  }

  // Get current user
  User? getCurrentUser() {
    return appLocalStorage.getCurrentUser();
  }

  // Check if user is authenticated
  bool isAuthenticated() {
    return appLocalStorage.getAppState() == 'authenticated' &&
        appLocalStorage.getCurrentUser() != null;
  }

  // Get all registered users (for admin purposes)
  List<User> getAllUsers() {
    return appLocalStorage.getAllUsers();
  }

  // Delete user account
  Future<bool> deleteAccount(String email) async {
    try {
      appLocalStorage.removeUser(email);
      // If it's the current user, sign them out
      final currentUser = getCurrentUser();
      if (currentUser?.email.toLowerCase() == email.toLowerCase()) {
        await signOut();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  void switchUser(User selectedUser) {
    appLocalStorage.saveCurrentUser(selectedUser);
    appGlobals.user = selectedUser;
  }
}

class AuthResult {
  final bool success;
  final String message;
  final User? user;

  AuthResult({
    required this.success,
    required this.message,
    this.user,
  });
}
