import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/violation/data/models/resend_link_request.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../domain/repositories/violation_repository.dart';

class ResendLinkState {
  final String email;
  final bool emailTouched;

  // New fields:
  final bool loading;
  final String? error;

  const ResendLinkState({
    this.email = '',
    this.emailTouched = false,
    this.loading = false,
    this.error,
  });

  ResendLinkState copyWith({
    String? email,
    bool? emailTouched,
    bool? loading,
    String? error,
  }) {
    return ResendLinkState(
      email: email ?? this.email,
      emailTouched: emailTouched ?? this.emailTouched,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}

class ResendLinkNotifier extends StateNotifier<ResendLinkState> {
  ResendLinkNotifier(this._repo)
    : controller = TextEditingController(),
      super(const ResendLinkState());

  final ViolationRepository _repo;
  final TextEditingController controller;
  bool isSubmitted = false;

  void updateEmail(String text) {
    final touched = state.emailTouched || text.isNotEmpty;
    controller.text = text;
    controller.selection = TextSelection.collapsed(offset: text.length);
    state = state.copyWith(email: text, emailTouched: touched);
  }

  bool canSubmit() {
    return emailIsValid();
  }

  bool emailIsValid() {
    return state.email.trim().split(RegExp(r'\s+')).length <= 50 &&
        state.email.isNotEmpty;
  }

  /// Submit selections to backend (or local sync)
  Future<void> submit() async {
    // prevent double‑tap
    if (state.loading) return;

    state = state.copyWith(loading: true, error: null);
    try {
      // example request object:
      final req = ResendLinkRequest.fromState(state);

      await _repo.submitResendLink(req);
      isSubmitted = true;

      // success → close popup, reset or navigate:
      state = state.copyWith(loading: false);
      // optionally: reset the form for next time
      reset();
    } catch (e) {
      // capture error message
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  void reset({bool fromSuccess = false}) {
    state = const ResendLinkState();
    controller.clear();
    if (fromSuccess) isSubmitted = false;
  }

  void resetError({bool fromSuccess = false}) {
    state = state.copyWith(error: null);
  }
}

final resendLinkProvider =
    StateNotifierProvider<ResendLinkNotifier, ResendLinkState>(
      (ref) => ResendLinkNotifier(ref.watch(violationRepositoryProvider)),
    );
