import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticateWithFingerprint() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        return false;
      }
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (!availableBiometrics.contains(BiometricType.fingerprint)) {
        return false;
      }

      bool authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate using your fingerprint',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      return authenticated;
    } on PlatformException catch (e) {
      log("Fingerprint auth error: $e");
      return false;
    }
  }

  /// Authenticate using Face ID.
  Future<bool> authenticateWithFaceId() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        return false;
      }
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (!availableBiometrics.contains(BiometricType.face)) {
        return false;
      }

      bool authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate using Face ID',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      return authenticated;
    } on PlatformException catch (e) {
      log("Face ID auth error: $e");
      return false;
    }
  }
}
