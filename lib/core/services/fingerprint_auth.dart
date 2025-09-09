import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

import '../di/locator.dart';

// ···
final LocalAuthentication auth = LocalAuthentication();
// ···
Future<bool> isFingerPrintAuthorized() async {
  if (appGlobals.isBiometricEnabled == true) {
    return fingerPrintAuthorization();
  } else {
    snackbarService.error(
      message: "Biometric is not enabled. Go to settings to enable it",
    );
    return false;
  }
}

Future<bool> fingerPrintAuthorization() async {
  try {
    final bool didAuthenticate = await auth.authenticate(
      localizedReason: 'Please authenticate to login',
      options: const AuthenticationOptions(
        useErrorDialogs: false,
        biometricOnly: true,
      ),
      authMessages: const <AuthMessages>[
        AndroidAuthMessages(
          signInTitle: 'Biometric authentication required!',
          cancelButton: 'No thanks',
        ),
        IOSAuthMessages(cancelButton: 'No thanks'),
      ],
    );
    // ···
    return didAuthenticate;
  } on PlatformException catch (e) {
    if (e.code == auth_error.notEnrolled) {
      // Add handling of no hardware here.
    } else if (e.code == auth_error.lockedOut ||
        e.code == auth_error.permanentlyLockedOut) {
      // ...
    } else {
      // ...
    }
    return false;
  }
}
