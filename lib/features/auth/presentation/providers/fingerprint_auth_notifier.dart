import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';


final biometricAuthProvider =
  StateNotifierProvider<BiometricAuthNotifier, BiometricAuthState>(
          (ref) => BiometricAuthNotifier()
  );


enum SupportState { unknown, supported, unsupported }

class BiometricAuthState {
  final SupportState supportState;
  final bool? canCheckBiometrics;
  final List<BiometricType>? availableBiometrics;
  final String authorized;
  final bool isAuthenticating;

  BiometricAuthState({
    this.supportState = SupportState.unknown,
    this.canCheckBiometrics,
    this.availableBiometrics,
    this.authorized = 'Not Authorized',
    this.isAuthenticating = false,
  });

  BiometricAuthState copyWith({
    SupportState? supportState,
    bool? canCheckBiometrics,
    List<BiometricType>? availableBiometrics,
    String? authorized,
    bool? isAuthenticating,
  }) {
    return BiometricAuthState(
      supportState: supportState ?? this.supportState,
      canCheckBiometrics: canCheckBiometrics ?? this.canCheckBiometrics,
      availableBiometrics: availableBiometrics ?? this.availableBiometrics,
      authorized: authorized ?? this.authorized,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
    );
  }
}

class BiometricAuthNotifier extends StateNotifier<BiometricAuthState> {
  BiometricAuthNotifier() : super(BiometricAuthState()) {
    _checkSupport();
  }

  final auth = LocalAuthentication();

  Future<void> _checkSupport() async {
    final supported = await auth.isDeviceSupported();
    state = state.copyWith(
        supportState: supported ? SupportState.supported : SupportState.unsupported);
  }

  Future<void> checkBiometrics() async {
    try {
      final result = await auth.canCheckBiometrics;
      state = state.copyWith(canCheckBiometrics: result);
    } on PlatformException catch (e) {
      print(e);
      state = state.copyWith(canCheckBiometrics: false);
    }
  }

  Future<void> getAvailableBiometrics() async {
    try {
      final list = await auth.getAvailableBiometrics();
      state = state.copyWith(availableBiometrics: list);
    } on PlatformException catch (e) {
      print(e);
      state = state.copyWith(availableBiometrics: []);
    }
  }

  Future<void> authenticate({bool biometricOnly = false}) async {
    try {
      state = state.copyWith(
        isAuthenticating: true,
        authorized: 'Authenticating',
      );

      final result = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate.',
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: biometricOnly,
        ),
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Verifying fingerprint',
            biometricHint: ''
          ),
          // IOSAuthMessages(
          //   cancelButton: 'No thanks',
          // ),
        ]
      );

      state = state.copyWith(
        isAuthenticating: false,
        authorized: result ? 'Authorized' : 'Not Authorized',
      );
    } on PlatformException catch (e) {
      print(e);
      state = state.copyWith(
        isAuthenticating: false,
        authorized: 'Error - ${e.message}',
      );
    }
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
    state = state.copyWith(isAuthenticating: false);
  }
}
