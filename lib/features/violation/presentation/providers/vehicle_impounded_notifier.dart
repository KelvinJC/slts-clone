import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/features/violation/data/models/vehicle_impounded_request.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../domain/repositories/violation_repository.dart';

class VehicleImpoundedState {
  final String comment;
  final bool commentTouched;

  // New fields:
  final bool loading;
  final String? error;

  const VehicleImpoundedState({
    this.comment = '',
    this.commentTouched = false,
    this.loading = false,
    this.error,
  });

  VehicleImpoundedState copyWith({
    String? comment,
    bool? commentTouched,
    bool? loading,
    String? error,
  }) {
    return VehicleImpoundedState(
      comment: comment ?? this.comment,
      commentTouched: commentTouched ?? this.commentTouched,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}

class VehicleImpoundedNotifier extends StateNotifier<VehicleImpoundedState> {
  VehicleImpoundedNotifier(this._repo)
    : controller = TextEditingController(),
      super(const VehicleImpoundedState());

  final ViolationRepository _repo;
  final TextEditingController controller;
  bool isSubmitted = false;

  void updateComment(String text) {
    final touched = state.commentTouched || text.isNotEmpty;
    controller.text = text;
    controller.selection = TextSelection.collapsed(offset: text.length);
    state = state.copyWith(comment: text, commentTouched: touched);
  }

  bool canSubmit() {
    return commentIsValid();
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
      final req = VehicleImpoundedRequest.fromState(state);

      await _repo.submitVehicleImpounded(req);
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
    state = const VehicleImpoundedState();
    controller.clear();
    if (fromSuccess) isSubmitted = false;
  }

  void resetError({bool fromSuccess = false}) {
    state = state.copyWith(error: null);
  }
}

final vehicleImpoundedProvider =
    StateNotifierProvider<VehicleImpoundedNotifier, VehicleImpoundedState>(
      (ref) => VehicleImpoundedNotifier(ref.watch(violationRepositoryProvider)),
    );
