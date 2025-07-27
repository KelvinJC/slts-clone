import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/injection.dart';
import '../../domain/entities/violation.dart';
import '../../domain/repositories/violation_repository.dart';
import '../../../../core/errors/failures.dart';

/// Immutable state for Run‑Plate lookup
class RunPlateState {
  final bool loading;
  final List<Violation>? results;
  final String? error;

  const RunPlateState({this.loading = false, this.results, this.error});

  RunPlateState copyWith({
    bool? loading,
    List<Violation>? results,
    String? error,
  }) {
    return RunPlateState(
      loading: loading ?? this.loading,
      results: results ?? this.results,
      error: error ?? this.error,
    );
  }
}

/// The StateNotifier which owns the controller + business logic
class RunPlateNotifier extends StateNotifier<RunPlateState> {
  RunPlateNotifier(this._repo)
    : controller = TextEditingController(),
      focusNode = FocusNode(),
      super(const RunPlateState());

  final ViolationRepository _repo;
  final TextEditingController controller;
  final FocusNode focusNode;

  /// Kick off a search based on current controller.text
  Future<void> search() async {
    final plate = controller.text.trim();
    if (plate.isEmpty) return;

    state = state.copyWith(loading: true, error: null);
    try {
      final list = await _repo.runPlateNumber(plate);
      state = state.copyWith(loading: false, results: list);
    } on Failure catch (f) {
      state = state.copyWith(loading: false, error: f.displayMessage);
    }
  }

  /// Programmatically set the plate text
  void setPlate(String plate) {
    controller.text = plate;
    controller.selection = TextSelection.collapsed(offset: plate.length);
    focusNode.requestFocus();
  }

  /// Clear both the controller and the state
  void clear() {
    state = const RunPlateState();
    controller.clear();
    focusNode.unfocus();
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }
}

/// The Riverpod provider for read & watch
final runPlateProvider = StateNotifierProvider<RunPlateNotifier, RunPlateState>(
  (ref) => RunPlateNotifier(ref.read(violationRepositoryProvider)),
);
