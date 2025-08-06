import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/core/errors/failures.dart';
import 'package:slts_enforcer_app/core/local_storage/local_storage.dart';
import 'package:slts_enforcer_app/core/services/biometric_service.dart';
import 'package:slts_enforcer_app/features/auth/domain/entities/user.dart';
import 'package:slts_enforcer_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:slts_enforcer_app/injection.dart';

/// The various steps in the authentication flow.
enum AuthStep {
  credentials, // entering email/password
  otp, // entering 2FA code
  authenticated,
}

/// Holds all the state needed to drive the authentication UI.
class AuthState {
  final AuthStep step;
  final bool loading;
  final bool biometricsLoading;
  final Failure? error;
  final User? user;

  final String email;
  final String password;
  final bool obscureText;
  // final String otp;

  const AuthState({
    this.step = AuthStep.credentials,
    this.loading = false,
    this.biometricsLoading = false,
    this.error,
    this.user,
    this.email = '',
    this.password = '',
    this.obscureText = true,
    // this.otp = '',
  });

  bool get emailValid {
    final re = RegExp(r'^[\w-.]+@([\w-]+\.)+\w{2,4}$');
    return re.hasMatch(email);
  }

  bool get passwordFilled => password.isNotEmpty;

  AuthState copyWith({
    AuthStep? step,
    bool? loading,
    bool? biometricsLoading,
    Failure? error,
    User? user,
    String? email,
    String? password,
    bool? obscureText,
    // String? otp,
  }) {
    return AuthState(
      step: step ?? this.step,
      loading: biometricsLoading ?? loading ?? this.loading,
      biometricsLoading: biometricsLoading ?? this.biometricsLoading,
      error: error,
      user: user ?? this.user,
      email: email ?? this.email,
      password: password ?? this.password,
      obscureText: obscureText ?? this.obscureText,
      // otp: otp ?? this.otp,
    );
  }
}

/// A [StateNotifier] that manages the two-step authentication flow:
/// 1) credentials → submit → OTP
/// 2) OTP → submit → authenticated user
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;
  final LocalStorage _storage;

  AuthNotifier(this._repo, this._storage) : super(const AuthState());

  /// Called on every email change
  void updateEmail(String email) {
    state = state.copyWith(email: email, error: null);
  }

  /// Called on every password change
  void updatePassword(String password) {
    state = state.copyWith(password: password, error: null);
  }

  /// Called on every OTP change
  // void updateOtp(String otp) {
  //   state = state.copyWith(otp: otp, error: null);
  // }

  /// Toggle password field visibility
  void togglePasswordVisibility() {
    state = state.copyWith(obscureText: !state.obscureText);
  }

  /// Step 1: send email & password
  Future<void> submitCredentials() async {
    state = state.copyWith(loading: true, error: null);

    try {
      await _repo.authenticate(state.email, state.password);
      state = state.copyWith(loading: false, step: AuthStep.otp);
    } on Failure catch (f) {
      state = state.copyWith(loading: false, error: f);
    }
  }

  /// Step 2: verify OTP (email was kept in state)
  Future<void> verifyOtp(String otp) async {
    state = state.copyWith(loading: true, error: null);
    try {
      final user = await _repo.verifyOtp(otp, state.email);
      state = state.copyWith(
        loading: false,
        step: AuthStep.authenticated,
        user: user,
      );
    } on Failure catch (f) {
      state = state.copyWith(loading: false, error: f);
    }
  }

  Future<void> loginWithBiometrics() async {
    state = state.copyWith(biometricsLoading: true, error: null);
    try {
      final useBio = await _storage.getUseBiometrics();
      final token = await _storage.getAuthToken();
      if (useBio && token != null) {
        // final ok = await BiometricService().authenticate();
        // if (!ok) return;

        state = state.copyWith(loading: true, error: null);
        try {
          final user = await _repo.loginWithToken();
          state = state.copyWith(
            biometricsLoading: false,
            step: AuthStep.authenticated,
            user: user,
          );
        } on Failure catch (f) {
          state = state.copyWith(biometricsLoading: false, error: f);
        }
      } else {
        final error = UnexpectedFailure(rawMessage: 'Biometrics not enabled');
        state = state.copyWith(biometricsLoading: false, error: error);
      }
    } catch (f) {
      late UnexpectedFailure error;
      // check if its PlatformException
      if (f is PlatformException) {
        error = UnexpectedFailure(rawMessage: f.message!);
      } else {
        print('Failed to login with biometrics: $f');
        error = UnexpectedFailure(
          rawMessage: 'Failed to login with biometrics',
        );
      }
      state = state.copyWith(biometricsLoading: false, error: error);
    }
  }
}

/// Provider for [AuthNotifier] — UI can call its methods and watch [AuthState].
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    ref.read(authRepositoryProvider),
    ref.read(localStorageProvider),
  ),
);
