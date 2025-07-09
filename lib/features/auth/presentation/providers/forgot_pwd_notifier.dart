import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/core/errors/failures.dart';
import 'package:slts_enforcer_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:slts_enforcer_app/injection.dart';

class ForgotPwdState {
  /// The email address the user typed.
  final String email;

  /// True when the “Send Link” call is in progress.
  final bool loading;

  /// Non‐null after a failure.
  final String? errorMessage;

  /// True once the link was successfully sent.
  final bool linkSent;

  const ForgotPwdState({
    this.email = '',
    this.loading = false,
    this.errorMessage,
    this.linkSent = false,
  });

  bool get emailValid {
    final re = RegExp(r'^[\w-.]+@([\w-]+\.)+\w{2,4}$');
    return re.hasMatch(email);
  }

  ForgotPwdState copyWith({
    String? email,
    bool? loading,
    String? errorMessage,
    bool? linkSent,
  }) {
    return ForgotPwdState(
      email: email ?? this.email,
      loading: loading ?? this.loading,
      // explicitly allow clearing the error by passing null:
      errorMessage: errorMessage,
      linkSent: linkSent ?? this.linkSent,
    );
  }
}

class ForgotPwdNotifier extends StateNotifier<ForgotPwdState> {
  ForgotPwdNotifier(this._repo) : super(const ForgotPwdState());

  final AuthRepository _repo;

  /// Called on every email change
  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  /// Calls the backend to send a reset link to [email].
  Future<void> sendLink() async {
    if (state.email.isEmpty) return;

    // 1) generate 6‑digit token
    final rnd = Random();
    final token = (100000 + rnd.nextInt(900000)).toString();

    // update state to loading and capture the email
    state = state.copyWith(
      loading: true,
      email: state.email,
      errorMessage: null,
      linkSent: false,
    );

    try {
      await _repo.forgotPassword(state.email, token);
      // success → clear loading, mark link sent
      state = state.copyWith(loading: false, linkSent: true);
    } on Failure catch (f) {
      // failure → clear loading, record error
      state = state.copyWith(loading: false, errorMessage: f.displayMessage);
    }
  }

  /// Reset everything back to the initial form.
  void reset() {
    state = const ForgotPwdState();
  }
}

/// The provider so your UI can `watch` and `read` this notifier.
final forgotPwdNotifierProvider =
    StateNotifierProvider<ForgotPwdNotifier, ForgotPwdState>(
      (ref) => ForgotPwdNotifier(ref.read(authRepositoryProvider)),
    );
