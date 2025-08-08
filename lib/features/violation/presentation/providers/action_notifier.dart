import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/violation/data/models/action_request.dart';
import 'package:slts_enforcer_app/features/violation/data/models/resend_link_request.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../domain/repositories/violation_repository.dart';

class ActionState {
  final String pcn;
  final String email;
  final bool emailTouched;
  final ActionType type;
  final String comment;
  final bool commentTouched;

  // New fields:
  final bool loading;
  final String? error;

  const ActionState({
    this.email = '',
    this.emailTouched = false,
    this.pcn = '',
    this.type = ActionType.vehicleImpounded,
    this.comment = '',
    this.commentTouched = false,
    this.loading = false,
    this.error,
  });

  ActionState copyWith({
    String? email,
    bool? emailTouched,
    String? pcn,
    ActionType? type,
    String? comment,
    bool? commentTouched,
    bool? loading,
    String? error,
  }) {
    return ActionState(
      email: email ?? this.email,
      emailTouched: emailTouched ?? this.emailTouched,
      pcn: pcn ?? this.pcn,
      type: type ?? this.type,
      comment: comment ?? this.comment,
      commentTouched: commentTouched ?? this.commentTouched,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  bool get canSubmitResendLink => emailIsValid && pcn.isNotEmpty;

  bool get emailIsValid =>
      RegExp(r'^[\w-.]+@([\w-]+\.)+\w{2,4}$').hasMatch(email) &&
      email.isNotEmpty;

  bool get commentIsValid => comment.trim().split(RegExp(r'\s+')).length <= 50;

  bool get canSubmitAction =>
      pcn.isNotEmpty &&
      (type == ActionType.driversLicense ||
          type == ActionType.vehicleParticulars) &&
      commentIsValid;
}

class ActionNotifier extends StateNotifier<ActionState> {
  ActionNotifier(this._repo)
    : emailController = TextEditingController(),
      commentController = TextEditingController(),
      super(const ActionState());

  final ViolationRepository _repo;
  final TextEditingController emailController;
  final TextEditingController commentController;
  bool isSubmitted = false;

  void updateEmail(String text) {
    final touched = state.emailTouched || text.isNotEmpty;
    emailController.text = text;
    emailController.selection = TextSelection.collapsed(offset: text.length);
    state = state.copyWith(email: text, emailTouched: touched);
  }

  void toggleDriversLicense(bool? value) {
    state = state.copyWith(type: ActionType.driversLicense);
  }

  void toggleVehicleParticulars(bool? value) {
    state = state.copyWith(type: ActionType.vehicleParticulars);
  }

  void toggleVehicleImpounded(bool? value) {
    state = state.copyWith(type: ActionType.vehicleImpounded);
  }

  void updateComment(String text) {
    final touched = state.commentTouched || text.isNotEmpty;
    commentController.text = text;
    commentController.selection = TextSelection.collapsed(offset: text.length);
    state = state.copyWith(comment: text, commentTouched: touched);
  }

  void updatePCNs(List<String> pcns) => state = state.copyWith(pcn: pcns.first);

  /// Submit selections to backend (or local sync)
  Future<void> submitAction() async {
    // prevent double‑tap
    if (state.loading) return;

    state = state.copyWith(loading: true, error: null);
    try {
      // example request object:
      final req = ActionRequest.fromState(state);

      await _repo.submitAction(req);
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

  /// Submit selections to backend (or local sync)
  Future<void> submitResendLink() async {
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
    state = const ActionState();
    // controller.clear();
    if (fromSuccess) isSubmitted = false;
  }

  void resetError({bool fromSuccess = false}) {
    state = state.copyWith(error: null);
  }
}

final idCaptureProvider = StateNotifierProvider<ActionNotifier, ActionState>(
  (ref) => ActionNotifier(ref.watch(violationRepositoryProvider)),
);
