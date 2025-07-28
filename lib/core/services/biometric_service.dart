import 'package:local_auth/local_auth.dart';

class BiometricService {
  final _auth = LocalAuthentication();

  Future<bool> get canCheckBiometrics => _auth.canCheckBiometrics;
  Future<bool> authenticate() => _auth.authenticate(
    localizedReason: 'Please authenticate to login',
    options: const AuthenticationOptions(biometricOnly: true),
  );
}
