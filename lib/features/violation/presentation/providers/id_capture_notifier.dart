import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/violation/data/models/id_capture_request.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../domain/repositories/violation_repository.dart';

class IdCaptureState {
  final bool hasDriversLicense;
  final bool hasVehicleParticulars;
  final String comment;
  final bool commentTouched;

  // New fields:
  final bool loading;
  final String? error;

  const IdCaptureState({
    this.hasDriversLicense = false,
    this.hasVehicleParticulars = false,
    this.comment = '',
    this.commentTouched = false,
    this.loading = false,
    this.error,
  });

  IdCaptureState copyWith({
    bool? hasDriversLicense,
    bool? hasVehicleParticulars,
    String? comment,
    bool? commentTouched,
    bool? loading,
    String? error,
  }) {
    return IdCaptureState(
      hasDriversLicense: hasDriversLicense ?? this.hasDriversLicense,
      hasVehicleParticulars:
          hasVehicleParticulars ?? this.hasVehicleParticulars,
      comment: comment ?? this.comment,
      commentTouched: commentTouched ?? this.commentTouched,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}

class IdCaptureNotifier extends StateNotifier<IdCaptureState> {
  IdCaptureNotifier(this._repo)
    : controller = TextEditingController(),
      super(const IdCaptureState());

  final ViolationRepository _repo;
  final TextEditingController controller;
  bool isSubmitted = false;

  void toggleDriversLicense(bool? value) {
    state = state.copyWith(hasDriversLicense: value);
  }

  void toggleVehicleParticulars(bool? value) {
    state = state.copyWith(hasVehicleParticulars: value);
  }

  void updateComment(String text) {
    final touched = state.commentTouched || text.isNotEmpty;
    controller.text = text;
    controller.selection = TextSelection.collapsed(offset: text.length);
    state = state.copyWith(comment: text, commentTouched: touched);
  }

  bool canSubmit() {
    return (state.hasDriversLicense || state.hasVehicleParticulars) &&
        commentIsValid();
  }

  bool commentIsValid() {
    return state.comment.trim().split(RegExp(r'\s+')).length <= 50 &&
        state.comment.isNotEmpty;
  }

  /// Submit selections to backend (or local sync)
  Future<void> submit() async {
    // prevent double‑tap
    if (state.loading) return;

    state = state.copyWith(loading: true, error: null);
    try {
      // example request object:
      final req = IdCaptureRequest.fromState(state);

      await _repo.submitIdCapture(req);
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
    state = const IdCaptureState();
    controller.clear();
    if (fromSuccess) isSubmitted = false;
  }

  void resetError({bool fromSuccess = false}) {
    state = state.copyWith(error: null);
  }
}

final idCaptureProvider =
    StateNotifierProvider<IdCaptureNotifier, IdCaptureState>(
      (ref) => IdCaptureNotifier(ref.watch(violationRepositoryProvider)),
    );
