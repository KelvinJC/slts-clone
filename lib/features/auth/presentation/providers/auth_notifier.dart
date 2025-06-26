import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

/// The various steps in the authentication flow.
enum AuthStep {
  /// Waiting for user to submit their email/password.
  credentials,

  /// Waiting for user to submit their one-time passcode (OTP).
  otp,

  /// Authentication complete; user is signed in.
  authenticated,
}

/// Holds all of the state needed to drive the authentication UI.
class AuthState {
  /// Which part of the flow we are in.
  final AuthStep step;

  /// Whether a network call is in progress.
  final bool loading;

  /// The last error that occurred, if any.
  final Failure? error;

  /// The authenticated user, once [step] == [AuthStep.authenticated].
  final User? user;

  /// The email used in the credentials step (needed for OTP).
  final String? email;

  /// Constructs a new [AuthState].
  ///
  /// Defaults to the credentials step with no loading, no error, and no user.
  const AuthState({
    this.step = AuthStep.credentials,
    this.loading = false,
    this.error,
    this.user,
    this.email,
  });

  /// Creates a copy of this [AuthState] but with the given fields replaced.
  AuthState copyWith({
    AuthStep? step,
    bool? loading,
    Failure? error,
    User? user,
    String? email,
  }) {
    return AuthState(
      step: step ?? this.step,
      loading: loading ?? this.loading,
      error: error,
      user: user ?? this.user,
      email: email ?? this.email,
    );
  }
}

/// A [StateNotifier] that manages the two-step authentication flow:
/// 1) username/password → OTP
/// 2) OTP → authenticated user
class AuthNotifier extends StateNotifier<AuthState> {
  /// The repository that performs the actual API calls.
  final AuthRepository _repo;

  /// Creates a new [AuthNotifier], initializing state to [AuthState].
  AuthNotifier(this._repo) : super(const AuthState());

  /// Step 1: Send email & password to the server.
  ///
  /// On success, advances [state.step] to [AuthStep.otp] and stores the [email]
  /// for the OTP step. On failure, captures the [Failure] in state.
  Future<void> authenticate(String email, String password) async {
    state = state.copyWith(loading: true, error: null);
    try {
      await _repo.authenticate(email, password);
      state = state.copyWith(loading: false, step: AuthStep.otp, email: email);
    } on Failure catch (f) {
      state = state.copyWith(loading: false, error: f);
    }
  }

  /// Step 2: Send the OTP token and previously stored email.
  ///
  /// On success, advances [state.step] to [AuthStep.authenticated] and
  /// stores the returned [User] in state. On failure, captures the [Failure].
  Future<void> verifyOtp(String otp) async {
    final email = state.email;
    if (email == null) {
      state = state.copyWith(
        error: UnexpectedFailure(
          rawMessage: 'Email is missing; please login again.',
        ),
      );
      return;
    }

    state = state.copyWith(loading: true, error: null);
    try {
      final user = await _repo.verifyOtp(otp, email);
      state = state.copyWith(
        loading: false,
        step: AuthStep.authenticated,
        user: user,
      );
    } on Failure catch (f) {
      state = state.copyWith(loading: false, error: f);
    }
  }

  /// Resets the flow back to the initial credentials step.
  void reset() {
    state = const AuthState();
  }
}

/// The provider for [AuthNotifier].
///
/// In your UI you can call:
/// ```dart
/// ref.read(authNotifierProvider.notifier).authenticate(email, password);
/// ref.read(authNotifierProvider.notifier).verifyOtp(code);
/// ```
/// And watch:
/// ```dart
/// final authState = ref.watch(authNotifierProvider);
/// ```
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.read(authRepositoryProvider)),
);

// final auth = ref.watch(authNotifierProvider);
// final authCtrl = ref.read(authNotifierProvider.notifier);

// if (auth.step == AuthStep.credentials) {
//   // show LoginScreen, button calls authenticate(...)
// } else if (auth.step == AuthStep.otp) {
//   // show OtpScreen, button calls verifyOtp(...)
// } else if (auth.step == AuthStep.authenticated) {
//   // navigate to HomeScreen
// }
