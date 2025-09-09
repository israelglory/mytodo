import 'package:stacked/stacked.dart';

import '../../core/cores.dart';

class ProfileViewModel extends BaseViewModel {
  bool isBiometricsEnabled = appGlobals.isBiometricsEnabled;

  void toggleBiometrics(bool value) {
    isBiometricsEnabled = value;
    authLocalStorage.saveBiometric(value);
    appGlobals.biometrics = value;
    notifyListeners();
  }
}
